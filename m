Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263807AbUFCSK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUFCSK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 14:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUFCSK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 14:10:58 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:25275 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263807AbUFCSK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 14:10:57 -0400
Date: Thu, 3 Jun 2004 14:10:54 -0400
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Lustre VFS patch, version 2
Message-ID: <20040603181054.GA12006@delft.aura.cs.cmu.edu>
Mail-Followup-To: Lars Marowsky-Bree <lmb@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040602231554.ADC7B3100AE@moraine.clusterfs.com> <20040603135952.GB16378@infradead.org> <20040603141922.GI4423@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603141922.GI4423@marowsky-bree.de>
User-Agent: Mutt/1.5.6i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 04:19:22PM +0200, Lars Marowsky-Bree wrote:
> First, Inter-mezzo is reasonably dead, from what I can see. As is Coda.
> You'll notice that the developers behind them have sort-of moved on to
> Lustre ;-)

Actually, Coda is not dead, there is still quite a bit of activity. It
is just seems slow on the kernel side because we actually have kernel
modules for various operating systems, FreeBSD, NetBSD, Windows 9x,
Windows NT/2000/XP, Solaris, and recently MacOS/Darwin. As a result we
are quite conservative as far as any significant changes in the
kernel-userspace interface.

Jan

