Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbQKVLGD>; Wed, 22 Nov 2000 06:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbQKVLFx>; Wed, 22 Nov 2000 06:05:53 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:25696 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129412AbQKVLFo>; Wed, 22 Nov 2000 06:05:44 -0500
Date: Wed, 22 Nov 2000 12:43:25 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Joseph Gooch <mrwizard@psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: ECN causing problems
In-Reply-To: <006301c05433$feb8c0c0$0200020a@wizws>
Message-ID: <Pine.LNX.4.21.0011221241420.26803-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Joseph Gooch wrote:

> My RaptorNT 6.5 firewall rejects all connections from my linux box when ECN
> is enabled.  The error is attached.  Perhaps this feature should be disabled
> by default?  Or is there already an option of the sort that i'm missing?  I
> only got the idea to disable it after a search of linux-kernel.

The're is variable in /proc somewhere. Teh firewall should be fixed, what
Linux is doing is legal to the RFC. Cisco fixed most of their products
that misbehaved. Complain to the guys who moade RaptorNT :)

> Plz cc me, I"m not on the list.
> 
> Later!
> Joe Gooch
> 



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
