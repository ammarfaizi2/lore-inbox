Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbRGAGdO>; Sun, 1 Jul 2001 02:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264993AbRGAGdE>; Sun, 1 Jul 2001 02:33:04 -0400
Received: from cs.columbia.edu ([128.59.16.20]:2485 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S264990AbRGAGct>;
	Sun, 1 Jul 2001 02:32:49 -0400
Message-Id: <200107010632.CAA26426@razor.cs.columbia.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Craig Milo Rogers <rogers@ISI.EDU>
cc: Dan Podeanu <pdan@spiral.extreme.ro>,
        Miquel van Smoorenburg <miquels@cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch. 
In-Reply-To: Your message of "Thu, 28 Jun 2001 13:18:14 PDT."
             <21297.993759494@ISI.EDU> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 Jul 2001 02:32:46 -0400
From: Hua Zhong <huaz@cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is this (printing out versions. etc) really a big deal so we should add stuff 
like "/proc/xxx", KERN_XXXX to make things more complicated?  It sounds to me 
like to make the kernel "smaller" we'd actually end up with adding more code 
and complexity to it.  And quite frankly, if people don't read MAINTAINERS, 
they won't read /proc/maintainers either.

> >Print all copyright, config, etc. as KERN_DEBUG.
> 
> 	How about a new level, say "KERN_CONFIG", with a "show-config"
> parameter to enable displaying KERN_CONFIG messages?


