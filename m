Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135196AbRDROvG>; Wed, 18 Apr 2001 10:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135197AbRDROuz>; Wed, 18 Apr 2001 10:50:55 -0400
Received: from cs.huji.ac.il ([132.65.16.10]:27342 "EHLO cs.huji.ac.il")
	by vger.kernel.org with ESMTP id <S135196AbRDROus>;
	Wed, 18 Apr 2001 10:50:48 -0400
Date: Wed, 18 Apr 2001 17:50:40 +0300 (IDT)
From: Yoav Etsion <etsman@cs.huji.ac.il>
To: linux-kernel@vger.kernel.org
cc: Tsafrir Dan <dants@cs.huji.ac.il>
Subject: Re: a quest for a better scheduler
Message-ID: <Pine.LNX.4.20_heb2.08.0104181741260.12639-100000@pomela2.cs.huji.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't want to open any old wounds, but I just got a summary from a
colleague of mine, Dan Tsafrir, who measured the context switch overhead 
on Linux with multiple processes. 

You can find the document at:
http://www.cs.huji.ac.il/~dants/linux-2.2.18-context-switch.ps

The measurements were taken on a quad Pentium III 550MHz IBM NetFinity
server with 1GB RAM. 

Even though this was done on the older 2.2.18 kernel, this is quite
intereseting with regard to the current scheduler discussion.


Yoav Etsion

