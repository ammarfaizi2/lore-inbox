Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263287AbTCNJC5>; Fri, 14 Mar 2003 04:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263288AbTCNJC5>; Fri, 14 Mar 2003 04:02:57 -0500
Received: from h88n1fls35o887.telia.com ([217.211.94.88]:64510 "EHLO
	filippan.pdc.kth.se") by vger.kernel.org with ESMTP
	id <S263287AbTCNJCz>; Fri, 14 Mar 2003 04:02:55 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-To: smeds@pdc.kth.se
To: "J.A. Magallon" <jamagallon@able.es>
cc: Mikael Pettersson <mikpe@user.it.uu.se>,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       smeds@filippan.pdc.kth.se
Subject: Re: [Perfctr-devel] Re: perfctr-2.5.0 released 
In-Reply-To: Message from "J.A. Magallon" <jamagallon@able.es> 
   of "Fri, 14 Mar 2003 02:25:02 +0100." <20030314012502.GA20357@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Mar 2003 10:10:50 +0100
Message-ID: <10132.1047633050@filippan.pdc.kth.se>
From: Nils Smeds <smeds@pdc.kth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Perhaps this has been asked for a million times, but I'm new to 
> perfctrs...
> Is there any tool available to profile a program based on this ?
> I have seen perfex, but that gives total counts. I would like something
> like gprof... We are now optimizing some software and I would like to
> make my colleagues leave Windows (they use Intel's VTune) and go to
> Linux.
> Or at least compare the same kind of things between VTune on win and
> 'something' in Linux that also uses the counters. They don't seem to
> trust gprof. And, looking at the results, I'm beginning to untrust
> VTune...
> 

Take a look at HPCView from Rice unversity. It might do what you are
looking for?

http://www.cs.rice.edu/~dsystem/hpcview/index.html

/Nils
-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   Nils Smeds                        http://www.pdc.kth.se/
   Center for Parallel Computers     e-mail: smeds@pdc.kth.se
   Royal Institute of Technology     Voice:  +46-8-7909115
   KTH                               Fax:    +46-8-247784 
   S-100 44 Stockholm, Sweden        Office: OB2, room 1546
-----------------------------------------------------------------------

