Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129147AbQKNJ6m>; Tue, 14 Nov 2000 04:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129212AbQKNJ6c>; Tue, 14 Nov 2000 04:58:32 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:65292 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129147AbQKNJ6X>; Tue, 14 Nov 2000 04:58:23 -0500
Message-ID: <3A1105B4.187F3270@idb.hist.no>
Date: Tue, 14 Nov 2000 10:28:20 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Michael Peddemors <michael@linuxmagic.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: reliability of linux-vm subsystem
In-Reply-To: <Pine.LNX.4.30.0011132116420.20626-100000@fs129-190.f-secure.com> <20001114004547.D12931@arthur.ubicom.tudelft.nl> <0011131653231G.24220@mistress>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Peddemors wrote:
> 
> > up to the sysadmin to enforce the policy. For the home user it means
> > that the distribution providers have to set decent limits,
> 
> What is decent today may not be with tommorows' newest softwares....
>
Which is why you upgrade your distribution now and then.  Or have 
a script setting a dynamic limit depending on available
memory & swap.
 
> >  for enterprises it means that they have to hire a sysadmin.
> 
> That is one of the reasons that small businesses are afraid to go to Linux
> now, because of the difficulty in finding skilled Linux sysadmins..
> 
The small business should use the distribution provided limit.

> "At least with the 'XX' Os, all they need to do is hire someone that can
> click buttons, either on the computer, or to the tech support line" is the
> perception, and with Linux they are already worried enough that they have to
> find a 'genius' to work on their systems fulltime..
> 
There are tech support lines for linux too, if you _pay_ for a
distribution.  You pay if you need it.

> It would be nice if 'advanced administration' can be kept to the minimum, so
> we can service MORE than one enterprise each :>

Sure.  My impression is that most of the advanced stuff is in the
installation and initial configuration.  There is very little
regular maintenance with linux.  Less than your typical GUI os anyway.
Easy installation looses its charm when you have to do it twice or more.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
