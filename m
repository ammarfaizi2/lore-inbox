Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270174AbRHMM4g>; Mon, 13 Aug 2001 08:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270176AbRHMM41>; Mon, 13 Aug 2001 08:56:27 -0400
Received: from femail34.sdc1.sfba.home.com ([24.254.60.24]:45564 "EHLO
	femail34.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270174AbRHMM4M>; Mon, 13 Aug 2001 08:56:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: "Samium Gromoff" <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: strange gcc crashes...
Date: Mon, 13 Aug 2001 05:56:06 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15WGJY-000Ecx-00@f12.port.ru>
In-Reply-To: <E15WGJY-000Ecx-00@f12.port.ru>
MIME-Version: 1.0
Message-Id: <01081305560700.00343@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 August 2001 04:55 am, Samium Gromoff wrote:
> at Aug 11, 01 06:51:15 PM +0000 Mark Hahn wrote:
> >>     so it seems to me like kernel problem...
> >
> >why is that?  I've never seen a sig11 from production >code
> >that wasn't caused by flakey ram.  in fact, your >descriptions
> >are a perfect example of similar hardware problems.
>
> and some other people told me about cpu overheating...
>
> but 55 minutes long memtest run showed no problems et al
>  with cpu (P166-nonMMX-oc`ed to 180) staying warm, not by any means hot
>  on mobo Zida 5DVX.
>
>  maybe 55 min is not enough for proper mem testing?

Synthetic tests are never as good as a real good gcc run, I'd *never* 
trust them over the indications given by attempting to compile the kernel 
or something big like XFree86.
