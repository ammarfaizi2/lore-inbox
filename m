Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277510AbRJERNQ>; Fri, 5 Oct 2001 13:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277512AbRJERNG>; Fri, 5 Oct 2001 13:13:06 -0400
Received: from mk-smarthost-1.mail.uk.worldonline.com ([212.74.112.71]:31241
	"EHLO mk-smarthost-1.mail.uk.worldonline.com") by vger.kernel.org
	with ESMTP id <S277510AbRJERMy>; Fri, 5 Oct 2001 13:12:54 -0400
Subject: Re: Development Setups
From: Andrew Ebling <kernelhacker@lineone.net>
To: adam.keys@HOTARD.engr.smu.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there>
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.29.08.00 (Preview Release)
Date: 05 Oct 2001 18:15:22 +0100
Message-Id: <1002302124.1034.5.camel@kernighan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was thinking of starting with a modern machine for developing/compiling on, 
> and then older machine(s) for testing.  This way I would not risk losing data 
> if I oops or somesuch.  Alternately, is there a common practice of using lilo 
> to create development and testing kernel command lines?  Is this a useful 
> thing to do or is it too much of brain drain to switch between hacking and 
> testing mindsets?

I like the two box strategy and have written a detailed description of
how to set it up (right down to the wiring diagram for the serial
cables):

http://www.kernelhacking.org/docs/2boxdebugging.txt

This will become part of the forthcoming kernelhacking-HOWTO...

Feedback on this document from anyone would be very much appreciated
from anyone :)

happy hacking,

Andy


