Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318005AbSFSVBS>; Wed, 19 Jun 2002 17:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318006AbSFSVBR>; Wed, 19 Jun 2002 17:01:17 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:21479 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S318005AbSFSVBR>; Wed, 19 Jun 2002 17:01:17 -0400
Message-Id: <200206192059.g5JKxF806954@mail.science.uva.nl>
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.23-dj2
Date: Wed, 19 Jun 2002 23:02:17 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020619205136.GA18903@suse.de>
In-Reply-To: <20020619205136.GA18903@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 22:51, Dave Jones wrote:
> Lots of bits got thrown out this time, as Christoph Hellwig went through
> the patch and picked up on quite a few obviously wrong bits. In addition,
> this patch introduces the mad axemen, who come to carve up all that is
> monolithic. Patrick's MTRR split-up has been around for a while, and could
> use a bit more testing before it goes to Linus. The AGPGART changes I did
> this afternoon, and haven't seen much testing at all yet.

I was busy testing it with 2.5.23-dj1...
got a panic, but could not save the output (and did not liked the idea to 
write it all down 8), also I thought it had notinhg to do with the agpgart 
split and wanted to try to run 2.5.23-dj1 first before reporting... ah well 
will try it with -dj2

	Rudmer
