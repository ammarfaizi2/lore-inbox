Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264613AbSJ3HXb>; Wed, 30 Oct 2002 02:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSJ3HXb>; Wed, 30 Oct 2002 02:23:31 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:54938
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S264613AbSJ3HXa>; Wed, 30 Oct 2002 02:23:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: landley@trommello.org, linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Date: Wed, 30 Oct 2002 02:29:44 -0500
User-Agent: KMail/1.4.2
Cc: reiser@namesys.com, alan@lxorguk.ukuu.org.uk, davem@redhat.com,
       boissiere@adiglobal.com
References: <200210272017.56147.landley@trommello.org>
In-Reply-To: <200210272017.56147.landley@trommello.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210300229.44865.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 October 2002 21:17, Rob Landley wrote:
> This is the next to last posting of this list.  (When abbott and costello
> meet the monster, its time is almost up.)  There will be at most one more,
> tomorrow, and it may just be a repost of this cc'd to Linus.  (Those
> of you waiting for the last minute, this would be it.)

Knock off initramfs off...I'll be posting something that
supercedes it (IMO) within the next 72 hours.

Aside from providing full untar suppprt, it DRAMATICALLY
cleans up do_mounts.c and moves all the initrd code that was
there to initrd.c. Infact I pretty much entirly rewrote initrd,
so it makes sense. (purging prehistoric junk, etc.)

Dave

