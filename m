Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263615AbUJ3GRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263615AbUJ3GRi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 02:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbUJ3GRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 02:17:38 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:9351 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263615AbUJ3GRg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 02:17:36 -0400
Date: Sat, 30 Oct 2004 10:18:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lxdialog question
Message-ID: <20041030081816.GA9645@mars.ravnborg.org>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0410292119540.23650@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0410292119540.23650@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 09:21:01PM +0200, Jan Engelhardt wrote:
> Hello,
> 
> 
> I wanted to patch lxdialog with the upstream code so that it supports UTF-8 i/o
> and utf-8-consoles, but I would need to know from which 'dialog' it forked in
> the past.

The only indication I could find was this note in scripts/README.Menuconfig:

---------------
The windowing support utility (lxdialog) is a VERY modified version of
the dialog utility by Savio Lam <lam836@cs.cuhk.hk>.  Although lxdialog
is significantly different from dialog, I have left Savio's copyrights
intact.  Please DO NOT contact Savio with questions about lxdialog.
He will not be able to assist.
---------------

	Sam
