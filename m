Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289655AbSBNJ0y>; Thu, 14 Feb 2002 04:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291038AbSBNJ0f>; Thu, 14 Feb 2002 04:26:35 -0500
Received: from [213.237.118.153] ([213.237.118.153]:6784 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S289655AbSBNJ0Y>;
	Thu, 14 Feb 2002 04:26:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.5-pre1
Date: Thu, 14 Feb 2002 10:22:11 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16bAWz-0002Qx-00@starship.berlin> <33319.192.168.200.20.1013650512.squirrel@bovendelft.xs4all.nl>
In-Reply-To: <33319.192.168.200.20.1013650512.squirrel@bovendelft.xs4all.nl>
Cc: "-= M.J. Prinsen =-" <various@bovendelft.xs4all.nl>
X-BeenThere: crackmonkey@crackmonkey.org
X-Fnord: +++ath
X-Message-Flag: Message text blocked
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16bI5o-0000EV-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 February 2002 02:35, -= M.J. Prinsen =- wrote:
> When compiling v2.5.5-pre1 I get the following error.
> I want to compile this kernel and boot my computer from a raid-0 array
> (Highpoint HPT370)
> Idea's?
>
This has been broken for a long time 2.5, the RAID both software and hardware 
havent been ported to the new block io layer. You are welcome to try, 
personally havent got a clue what needs to be changed.

greetings
-Allan
