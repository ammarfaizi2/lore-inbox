Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265155AbRFUTfV>; Thu, 21 Jun 2001 15:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265156AbRFUTfL>; Thu, 21 Jun 2001 15:35:11 -0400
Received: from geos.coastside.net ([207.213.212.4]:34757 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S265155AbRFUTex>; Thu, 21 Jun 2001 15:34:53 -0400
Mime-Version: 1.0
Message-Id: <p05100327b757fc43c456@[207.213.214.37]>
In-Reply-To: <E15D9mV-0001wf-00@the-village.bc.nu>
In-Reply-To: <E15D9mV-0001wf-00@the-village.bc.nu>
Date: Thu, 21 Jun 2001 12:34:21 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, wweng@kencast.com (Wei Weng)
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Controversy over dynamic linking -- how to end the panic
Cc: ttabi@interactivesi.com (Timur Tabi), linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 8:06 PM +0100 2001-06-21, Alan Cox wrote:
>  > > the stdio.h, I'd tell him to go screw himself.
>>  What is the difference between including kernel header file and
>>  including GPLed header file?
>
>There are real differences between programs and interface definitions. At this
>point you get into law and the like and its probably best you read up on it
>from a reputable source not l/k

Though header files don't fall clearly on the interface-definition 
side of the line. ctype.h, for example, in userland, or any other 
header with #defined or inline code.
-- 
/Jonathan Lundell.
