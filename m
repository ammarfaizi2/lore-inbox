Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315755AbSEDAaH>; Fri, 3 May 2002 20:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315756AbSEDAaG>; Fri, 3 May 2002 20:30:06 -0400
Received: from mnh-1-29.mv.com ([207.22.10.61]:12557 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S315755AbSEDAaG>;
	Fri, 3 May 2002 20:30:06 -0400
Message-Id: <200205040132.UAA05843@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Guest section DW <dwguest@win.tue.nl>, Gerrit Huizenga <gh@us.ibm.com>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: Re: UML is now self-hosting! 
In-Reply-To: Your message of "Fri, 03 May 2002 23:51:02 +0200."
             <20020503215102.GA24653@win.tue.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 20:32:27 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dwguest@win.tue.nl said:
> Congratulations!

Thanks! 

> Now that you can run UML
> under UML, can you run UML under UML under UML?] 

Heh, I haven't tried it.  Feel free, it should work now.

gh@us.ibm.com said:
> Customers wanted to run legacy OS/390 apps that they had lost the
> binaries for, with a fast, modern database (Oracle or DB2) running at
> native speed, with either Linux or Windows applications.  Add UML and
> you can do development and client support like System 390 can do with
> Linux and you have an interesting (if a bit perverted ;-) world.

Yup.  And that sort of thing doesn't come close to reaching the potential
of a virtual OS.

A couple of the intermediate-term things I'm most interested in are
	embedding UML in things like Apache to provide a standard internal
	development and execution environment

	spreading a SMP UML instance across multiple hosts

				Jeff

