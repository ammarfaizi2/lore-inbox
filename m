Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263272AbTCNBOS>; Thu, 13 Mar 2003 20:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263273AbTCNBOS>; Thu, 13 Mar 2003 20:14:18 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:10436 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S263272AbTCNBOR>;
	Thu, 13 Mar 2003 20:14:17 -0500
Date: Fri, 14 Mar 2003 02:25:02 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: perfctr-2.5.0 released
Message-ID: <20030314012502.GA20357@werewolf.able.es>
References: <200303110002.h2B02Uxa025848@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200303110002.h2B02Uxa025848@harpo.it.uu.se>; from mikpe@user.it.uu.se on Tue, Mar 11, 2003 at 01:02:30 +0100
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.11, Mikael Pettersson wrote:
> Version 2.5.0 of perfctr, the Linux/x86 performance
> monitoring counters driver, is now available at the usual
> place: http://www.csd.uu.se/~mikpe/linux/perfctr/
> 

Perhaps this has been asked for a million times, but I'm new to 
perfctrs...
Is there any tool available to profile a program based on this ?
I have seen perfex, but that gives total counts. I would like something
like gprof... We are now optimizing some software and I would like to
make my colleagues leave Windows (they use Intel's VTune) and go to
Linux.
Or at least compare the same kind of things between VTune on win and
'something' in Linux that also uses the counters. They don't seem to
trust gprof. And, looking at the results, I'm beginning to untrust
VTune...

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is 
like sex:
werewolf.able.es                         \           It's better when 
it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre5-jam0 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
