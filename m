Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282056AbRLMKHn>; Thu, 13 Dec 2001 05:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281818AbRLMKHe>; Thu, 13 Dec 2001 05:07:34 -0500
Received: from [195.66.192.167] ([195.66.192.167]:25868 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S282981AbRLMKHW>; Thu, 13 Dec 2001 05:07:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Caleb Moore <donscarletti@ozemail.com>, linux-kernel@vger.kernel.org
Subject: Re: swapping problem on kernel >= 2.4.14
Date: Thu, 13 Dec 2001 12:06:28 -0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011213204810.A2759@Duron>
In-Reply-To: <20011213204810.A2759@Duron>
MIME-Version: 1.0
Message-Id: <01121312062800.02011@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 December 2001 07:48, Caleb Moore wrote:
> I have tried to change to kernel 2.4.16 from 2.4.13 and my system crashes
> every time it starts using swap. This is the case down to 2.4.14 even when
> it is built using default options. My system is a AMD duron with 128MB of
> RAM and two swap partitions both 128MB on my non boot hard drive.
>
> could someone please fix this

You can significantly raise probability of this being fixed with some
investigation: does it crash with one swap partition? without swap partitions?
with swap file? does it produce an oops? etc
--
vda
