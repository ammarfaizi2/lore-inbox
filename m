Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUAERlP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbUAERlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:41:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:29655 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265170AbUAERlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:41:08 -0500
Date: Mon, 5 Jan 2004 09:37:45 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: venom@sns.it
Cc: sglines@is-cs.com, linux-kernel@vger.kernel.org
Subject: Re: file system technical comparisons
Message-Id: <20040105093745.2fc3ffd3.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.43.0401051037310.32446-100000@cibs9.sns.it>
References: <3FF5E4CE.60606@is-cs.com>
	<Pine.LNX.4.43.0401051037310.32446-100000@cibs9.sns.it>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004 10:42:32 +0100 (CET) venom@sns.it wrote:

| 
| http://www.linux-mag.com/2002-10/jfs_01.html
| 
| On some point it could be discussed, but it is a good starting point.
| 
| if you know italian, I will send you another article published in three part
| on Linux&C (http://www.oltrelinux.com) about journaled filesystems available in
| Linux kernel.
| 
| bests
| 
| Luigi
| 
| On Fri, 2 Jan 2004, Steve Glines wrote:
| 
| > Date: Fri, 02 Jan 2004 16:38:22 -0500
| > From: Steve Glines <sglines@is-cs.com>
| > To: linux-kernel@vger.kernel.org
| > Subject: file system technical comparisons
| >
| > I'm looking for a technical comparison between the major file systems.
| > At a minimum I'd like to see a comparison between ext3, reiserfs, xfs
| > and jfs. In the oh so perfect world I'd like to see detailed info on all
| > supported file systems.
| >
| > Please CC or mail me directly as I am not a subscriber to this list.
| >
| > Thanks
| > --
| > Steve Glines

A couple of years ago I did a journaling filesystems comparison
for 2.4.x, so it's quite dated.  I wouldn't pay much attention to
the performance numbers from then.

You can get some other (non-performance) comparison info by looking
at <http://developer.osdl.org/rddunlap/journal_fs/lwe-jgfs.pdf>.

--
~Randy
MOTD:  Always include version info.
