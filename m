Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbTABP4G>; Thu, 2 Jan 2003 10:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbTABP4G>; Thu, 2 Jan 2003 10:56:06 -0500
Received: from main.gmane.org ([80.91.224.249]:28395 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S262360AbTABP4F>;
	Thu, 2 Jan 2003 10:56:05 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Steven Barnhart" <sbarn03@softhome.net>
Subject: Re: [2.5.54, PNP, SOUND] compile error
Date: Thu, 02 Jan 2003 11:04:17 -0500
Message-ID: <pan.2003.01.02.16.04.00.473440@softhome.net>
References: <87hecr4w6x.fsf@jupiter.jochen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.0 (The whole remains beautiful)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jan 2003 12:39:50 +0100, Jochen Hein wrote:

> 
> It compiled well without PNP, now with the following PNP in .config:
> 
> #
> # Plug and Play support
> #
> CONFIG_PNP=y
> CONFIG_PNP_NAMES=y
> CONFIG_PNP_CARD=y
> CONFIG_PNP_DEBUG=y
> 
> #
> # Protocols
> #
> CONFIG_ISAPNP=y
> CONFIG_PNPBIOS=y

I got the same problem. I am guessing maybe a missing include file?

Steven



