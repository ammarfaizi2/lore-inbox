Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbUCITdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbUCITa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:30:29 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:12693 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262134AbUCIT1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:27:51 -0500
Date: Tue, 9 Mar 2004 20:28:54 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Lukasz Trabinski <lukasz@trabinski.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.4-rc2
Message-ID: <20040309192854.GB2182@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Lukasz Trabinski <lukasz@trabinski.net>, linux-kernel@vger.kernel.org
References: <200403080043.i280hlYj005348@lt.wsisiz.edu.pl> <404BCA97.2070502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404BCA97.2070502@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 08:21:27PM -0500, Jeff Garzik wrote:
> Looks like you need to do a 'make oldconfig' ?

If this cured it I would like to know.
Because kbuild should run "make silentoldconfig" if needed.
Timestamps of all KConfig files are checked etc.

	Sam
