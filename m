Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWESWk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWESWk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 18:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWESWk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 18:40:58 -0400
Received: from web26611.mail.ukl.yahoo.com ([217.146.177.63]:18516 "HELO
	web26611.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751380AbWESWk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 18:40:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QAFfOP/9qS7XPMIBLuAGx48s9S1j8X7i6JUJiPqzWs9DALf2X3S1PDE5PD2b0sDqq5QEMaP7MUgkciX1mzegCYHPgrpmSCAi9gpQ51JWajvB3aI7JhDV4k+gAgvYMfIcZDXyqDLxRpp8/7C37PxGQ4tz6yWFKJyHvKdkW+vrrSQ=  ;
Message-ID: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
Date: Sat, 20 May 2006 00:40:56 +0200 (CEST)
From: linux cbon <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <446D8F36.3010201@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Helge Hafting <helge.hafting@aitel.hist.no> a
écrit : 

>There is nothing "modern" about graphichs in the
kernel.

It depends on the meaning of graphics :
If it is direct card access, then kernel job.
If it is higher level like window system etc, then it
can be discussed...


>The modern (and safe) approach
>is graphichs separated from the kernel.  This is one
of the many
>things that unix got right from the very start.

Unix was not designed for graphics.


>Second - who cares what is "modern" or
"fashionable"???
>Nobody, except people buying clothes.  For computer
>software, we care about stability and performance.

Is X so stable and performant ?
For instance, X is not precise enough to make
compatible implementations.
X.free and X.org are not compatible.
Some graphic drivers work only with special versions
of X.org.
Gnome and KDE are not compatible.
etc.
Other example : can X follow new graphic progress ?


>but then there is no reason to stick it in the
kernel.

Usual reasons : Reusability, portability, ease of
maintenance, speed, etc.

What do you think of solutions using framebuffers like
directfb or fbui ?
It is in the kernel, the hardw access is direct, it is
fast and stable.

Why X.Org puts so many layers between the hardware and
the screen ? It adds complexity and slowness to the
project.

I think the discussion should move to X.Org ?


Regards












	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
