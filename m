Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRDFOo6>; Fri, 6 Apr 2001 10:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131659AbRDFOor>; Fri, 6 Apr 2001 10:44:47 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:15883 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S131638AbRDFOoc>; Fri, 6 Apr 2001 10:44:32 -0400
Date: Fri, 6 Apr 2001 07:43:29 -0700 (PDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Wichert Akkerman <wichert@cistron.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: syslog insmod please!
In-Reply-To: <9akic6$v0c$1@picard.cistron.nl>
Message-ID: <Pine.LNX.4.32.0104060730530.17426-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Wichert ,

On 6 Apr 2001, Wichert Akkerman wrote:
> In article <Pine.LNX.4.32.0104060429500.17426-100000@filesrv1.baby-dragons.com>,
> Mr. James W. Laferriere <babydr@baby-dragons.com> wrote:
> >	Not the problem being discussed ,  This is a user now root &
> >	having gained root is now attempting to from the command line
> >	to load a module .  How do we get this event recorded ?
> Recent versions of modutils (2.4.3 and later iirc) log that info
> in /var/log/ksymoops
	Thank you .  Does anyone know why this information is being put
	into /var/log/ksymoops ?  If anything I'd have used a differant
	filename .  Tia ,  JimL

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

