Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbRE3Fqb>; Wed, 30 May 2001 01:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262619AbRE3FqV>; Wed, 30 May 2001 01:46:21 -0400
Received: from [203.143.19.4] ([203.143.19.4]:52498 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S262622AbRE3FqR>;
	Wed, 30 May 2001 01:46:17 -0400
Date: Wed, 30 May 2001 11:02:19 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Robert Siemer <Robert.Siemer@gmx.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compiler warning fix in aci.c
In-Reply-To: <Pine.LNX.4.21.0105300125420.424-100000@presario>
Message-ID: <Pine.LNX.4.21.0105301100130.273-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 May 2001, Anuradha Ratnaweera wrote:

> Following patch fixes a compiler warning in aci.c.

I can guess the usefullness of the functiion print_bits that would be
removed if my patch is applied. If this is so, how about putting it inside
an "#ifdef DEBUG"?

Regards,

Anuradha

----------------------------------
http://www.bee.lk/people/anuradha/

