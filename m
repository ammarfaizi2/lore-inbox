Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270223AbRHGOms>; Tue, 7 Aug 2001 10:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270222AbRHGOmi>; Tue, 7 Aug 2001 10:42:38 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:53222 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S270223AbRHGOme>; Tue, 7 Aug 2001 10:42:34 -0400
Date: Tue, 7 Aug 2001 07:48:11 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Brian May <bam@snoopy.apana.org.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <84zo9ci4dk.fsf@scrooge.chocbit.org.au>
Message-ID: <Pine.LNX.4.33.0108070706250.6350-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Aug 2001, Brian May wrote:
>
> Example: disk is faulty and will no longer work. How do you guarantee
> that nobody will be able to read it after you toss it out OR return it
> to the manufacturer to claim for warranty?

if it's bad you should think nothing of taking the dewalt cordless, and
putting a hole through the platters and the case...

> (of course, encrypting swap space is only part of the solution, here
> you need to encrypt everything).

It's clear that reiserfs is headed that direction.

You can already mount an encrypted filesystem via the loopback interface.
and there's no particular reason why you actually need swap in the
first place. There are certianly valid reasons why you want swap (not
enough memory for example) but enough ram to run without swap is a pretty
attainable target on your average desktop machine these days if you want
it(512MB is about $100 US in two dimms)

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


