Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279838AbRKVQMw>; Thu, 22 Nov 2001 11:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279981AbRKVQMj>; Thu, 22 Nov 2001 11:12:39 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:7617 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S279969AbRKVQMg>; Thu, 22 Nov 2001 11:12:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: war <war@starband.net>, Oliver Neukum <oliver@neukum.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 16:12:32 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <01112211150302.00690@argo> <3BFD214F.36A55D94@starband.net>
In-Reply-To: <3BFD214F.36A55D94@starband.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166wSm-00063a-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 November 2001 4:01 pm, war wrote:
> Once again, I have enough ram where I am not going to run out for the
> things I do.
> I never need swap.
>
> When the system swaps, it slows down the system responsiveness big time.

"when it swaps" is meaningless: Linux ALWAYS swaps when there is swapspace. 
Do you mean when it *thrashes*? Or does your system have problems during I/O 
such as not using DMA for disk access?


James.
