Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265634AbRFWFLn>; Sat, 23 Jun 2001 01:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbRFWFLd>; Sat, 23 Jun 2001 01:11:33 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:41482 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265634AbRFWFLZ>; Sat, 23 Jun 2001 01:11:25 -0400
Message-Id: <200106230511.f5N5BMU84559@aslan.scsiguy.com>
To: David Ford <david@blue-labs.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Fri, 22 Jun 2001 21:41:22 PDT."
             <3B341DF2.9010904@blue-labs.org> 
Date: Fri, 22 Jun 2001 23:11:22 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Here is the output of a plain jane 2.4.5 compile with the 'new' adaptec 
>compiled in:

Yup.  Interrupts are not working for the chip.  See my other reply
for a possible work around.

--
Justin
