Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbRHOVbH>; Wed, 15 Aug 2001 17:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRHOVa5>; Wed, 15 Aug 2001 17:30:57 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:49751 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S266706AbRHOVan>; Wed, 15 Aug 2001 17:30:43 -0400
Date: Wed, 15 Aug 2001 16:30:27 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200108152130.QAA30162@tomcat.admin.navo.hpc.mil>
To: alan@lxorguk.ukuu.org.uk,
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <E15X74U-0003va-00@the-village.bc.nu>
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), mag@fbab.net,
        linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Not really. Large installations use ACLs instead of groups. 
> 
> Umm you can't use ACL's for resource management. You have to be able to
> charge an entity. Its not a permission to access, its a "who is paying" and
> that requires a real entity to charge to

And that calls for an accounting id or a project id. As well as the possiblity
of a user having multiple accounting ids.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
