Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUAFMEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUAFMEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:04:44 -0500
Received: from cibs9.sns.it ([192.167.206.29]:6414 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S262041AbUAFMEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:04:38 -0500
Date: Tue, 6 Jan 2004 13:04:24 +0100 (CET)
From: venom@sns.it
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: sglines@is-cs.com, <linux-kernel@vger.kernel.org>
Subject: Re: file system technical comparisons
In-Reply-To: <20040105093745.2fc3ffd3.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.43.0401061300550.13594-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What would be interesting is a new comparison between reiserFS reiser4 and
latest XFS. To be onest I think ext3, with or withou HTree, obsolete, but it is
abvious if you consider its origins, while I do not speack about JFS, since
technically is interesting, but then the bench I did, more than an year ago,
were not untisiasmant, and it was buggy when in a DIR there were too many
"small" files.

Luigi


On Mon, 5 Jan 2004, Randy.Dunlap wrote:

> Date: Mon, 5 Jan 2004 09:37:45 -0800
> From: Randy.Dunlap <rddunlap@osdl.org>
> To: venom@sns.it
> Cc: sglines@is-cs.com, linux-kernel@vger.kernel.org
> Subject: Re: file system technical comparisons
>
> On Mon, 5 Jan 2004 10:42:32 +0100 (CET) venom@sns.it wrote:
>
> |
> | http://www.linux-mag.com/2002-10/jfs_01.html
> |
> | On some point it could be discussed, but it is a good starting point.
> |
> | if you know italian, I will send you another article published in three part
> | on Linux&C (http://www.oltrelinux.com) about journaled filesystems available in
> | Linux kernel.
> |
> | bests
> |
> | Luigi
> |
> | On Fri, 2 Jan 2004, Steve Glines wrote:
> |
> | > Date: Fri, 02 Jan 2004 16:38:22 -0500
> | > From: Steve Glines <sglines@is-cs.com>
> | > To: linux-kernel@vger.kernel.org
> | > Subject: file system technical comparisons
> | >
> | > I'm looking for a technical comparison between the major file systems.
> | > At a minimum I'd like to see a comparison between ext3, reiserfs, xfs
> | > and jfs. In the oh so perfect world I'd like to see detailed info on all
> | > supported file systems.
> | >
> | > Please CC or mail me directly as I am not a subscriber to this list.
> | >
> | > Thanks
> | > --
> | > Steve Glines
>
> A couple of years ago I did a journaling filesystems comparison
> for 2.4.x, so it's quite dated.  I wouldn't pay much attention to
> the performance numbers from then.
>
> You can get some other (non-performance) comparison info by looking
> at <http://developer.osdl.org/rddunlap/journal_fs/lwe-jgfs.pdf>.
>
> --
> ~Randy
> MOTD:  Always include version info.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

