Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283409AbRLMFrK>; Thu, 13 Dec 2001 00:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283430AbRLMFrA>; Thu, 13 Dec 2001 00:47:00 -0500
Received: from zok.sgi.com ([204.94.215.101]:20374 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S283409AbRLMFqn>;
	Thu, 13 Dec 2001 00:46:43 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rob Hensley <zoid@zoid.staticky.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: debian unstable and 2.4.16-pre8... 
In-Reply-To: Your message of "Wed, 12 Dec 2001 21:33:44 CDT."
             <Pine.LNX.4.33.0112122124480.21682-100000@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Dec 2001 16:46:30 +1100
Message-ID: <24459.1008222390@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001 21:33:44 -0500 (EST), 
Rob Hensley <zoid@zoid.staticky.com> wrote:
>drivers/pcmcia/pcmcia.o(.data+0x1294): undefined reference to `local
>symbols in discarded section .text.exit'

I might have missed a devexit_p or it might be a real bug.  Config
please so I can reproduce it.  BTW, did you apply any patches beside
2.4.17-pre8?

