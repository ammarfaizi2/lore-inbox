Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbTHZRqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbTHZRqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:46:22 -0400
Received: from windsormachine.com ([206.48.122.28]:57521 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S262587AbTHZRqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:46:19 -0400
Date: Tue, 26 Aug 2003 13:46:18 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Stable P4 Mother board?  Hard Lockups: Asus P4B533-E, SiS680
 IDE
In-Reply-To: <3F4B939D.FD19B561@vtc.edu.hk>
Message-ID: <Pine.LNX.4.56.0308261343130.23883@router.windsormachine.com>
References: <3F4B939D.FD19B561@vtc.edu.hk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Nick Urbanik wrote:

> What modern motherboards work well with Linux?
> What IDE cards work well?

I'm using the ASUS P4B533's and P4B533-E's here successfully, very stable
motherboards, both on our Windows PC's and Linux servers.

As well, there's a few MSI 845 based boards being used here.

3ware makes very nice cards, both in the PATA(7xxx) and SATA(8xxx)
versions.  Be warned, they're more expensive than other IDE cards.
They're made in 2, 4, 8 and 12 port models.

I've had problems with both Promise and Highpoint cards in the
past(highpoint hpt366's were especially buggy under any OS).

The 3ware's can be used with software or hardware raid(they're hardware),
and seem to be actively supported by 3ware.

Mike
