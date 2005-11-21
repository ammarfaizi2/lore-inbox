Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVKUJop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVKUJop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 04:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVKUJop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 04:44:45 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:15690 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932249AbVKUJop convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 04:44:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h75rlRmJS15PG6J4ckEQIzkzNjsd4zkJKUw4KqlidlxFYQwcKrm6Lq4NBss6f8DWOFqXVHpjB4QOj1mJc4IQ7SDnil3uzOt3CIWopph/Yq77VdCfKloS0v+bXyaL8rMGk2vW4RfJNqI5GozeSiQdQ2XyPmqHqkdTrGsSar3fc/o=
Message-ID: <11b141710511210144h666d2edfi@mail.gmail.com>
Date: Mon, 21 Nov 2005 09:44:42 +0000
From: Paulo Jorge Matos <pocmatos@gmail.com>
Reply-To: pocm@sat.inesc-id.pt
To: Alfred Brons <alfredbrons@yahoo.com>
Subject: Re: what is our answer to ZFS?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051121092841.47907.qmail@web36409.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051121092841.47907.qmail@web36409.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check Tarkan "Sun ZFS and Linux" topic on 18th Nov,  on this mailing list.
http://marc.theaimsgroup.com/?l=linux-kernel&m=113235728212352&w=2

Cheers,

Paulo Matos

On 21/11/05, Alfred Brons <alfredbrons@yahoo.com> wrote:
> Hi All,
>
> I just noticed in the news this link:
>
> http://www.opensolaris.org/os/community/zfs/demos/basics
>
> I wonder what would be our respond to this beaste?
>
> btw, you could try it live by using Nexenta
> GNU/Solaris LiveCD at
> http://www.gnusolaris.org/gswiki/Download which is
> Ubuntu-based OpenSolaris
> distribution.
>
> So what is ZFS?
>
> ZFS is a new kind of filesystem that provides simple
> administration, transactional semantics, end-to-end
> data integrity, and immense scalability. ZFS is not an
> incremental improvement to existing technology; it is
> a fundamentally new approach to data management. We've
> blown away 20 years of obsolete assumptions,
> eliminated complexity at the source, and created a
> storage system that's actually a pleasure to use.
>
> ZFS presents a pooled storage model that completely
> eliminates the concept of volumes and the associated
> problems of partitions, provisioning, wasted bandwidth
> and stranded storage. Thousands of filesystems can
> draw from a common storage pool, each one consuming
> only as much space as it actually needs.
>
> All operations are copy-on-write transactions, so the
> on-disk state is always valid. There is no need to
> fsck(1M) a ZFS filesystem, ever. Every block is
> checksummed to prevent silent data corruption, and the
> data is self-healing in replicated (mirrored or RAID)
> configurations.
>
> ZFS provides unlimited constant-time snapshots and
> clones. A snapshot is a read-only point-in-time copy
> of a filesystem, while a clone is a writable copy of a
> snapshot. Clones provide an extremely space-efficient
> way to store many copies of mostly-shared data such as
> workspaces, software installations, and diskless
> clients.
>
> ZFS administration is both simple and powerful. The
> tools are designed from the ground up to eliminate all
> the traditional headaches relating to managing
> filesystems. Storage can be added, disks replaced, and
> data scrubbed with straightforward commands.
> Filesystems can be created instantaneously, snapshots
> and clones taken, native backups made, and a
> simplified property mechanism allows for setting of
> quotas, reservations, compression, and more.
>
> Alfred
>
>
>
> __________________________________
> Yahoo! FareChase: Search multiple travel sites in one click.
> http://farechase.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Paulo Jorge Matos - pocm at sat inesc-id pt
Web: http://sat.inesc-id.pt/~pocm
Computer and Software Engineering
INESC-ID - SAT Group
