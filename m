Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129658AbQKHLaw>; Wed, 8 Nov 2000 06:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129965AbQKHLam>; Wed, 8 Nov 2000 06:30:42 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:53038 "EHLO
	amsmta03-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129658AbQKHLaf>; Wed, 8 Nov 2000 06:30:35 -0500
Date: Wed, 8 Nov 2000 13:38:18 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Tim Waugh <twaugh@redhat.com>
cc: RAJESH BALAN <atmproj@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: malloc(1/0) ??
In-Reply-To: <20001107235800.R17245@redhat.com>
Message-ID: <Pine.LNX.4.21.0011081338030.1193-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Tim Waugh wrote:

> On Wed, Nov 08, 2000 at 01:41:40AM +0100, Igmar Palsenberg wrote:
> 
> > malloc(0) is bogus in this case. malloc(0) == free();
> 
> No, you're thinking of realloc.

Yep. My error. Sorry.


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
