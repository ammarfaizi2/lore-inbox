Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbULJNAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbULJNAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbULJNAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 08:00:41 -0500
Received: from tag.witbe.net ([81.88.96.48]:10894 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261196AbULJNAd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 08:00:33 -0500
Message-Id: <200412101300.iBAD0Ua31686@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Timothy Chavez'" <chavezt@gmail.com>, <linux-kernel@vger.kernel.org>
Cc: <serue@us.ltcfwd.linux.ibm.com>, <sds@epoch.ncsc.mil>, <rml@novell.com>,
       <ttb@tentacle.dhs.org>
Subject: Re: [audit] Upstream solution for auditing file system objects
Date: Fri, 10 Dec 2004 14:00:24 +0100
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <f2833c760412091602354b4c95@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcTeS7QtH6fS0axtTaOh7iQCRGwcrQAbFymQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

You could also have a look at LIDS. Though the target is not the same,
some useful idea may be gathered there...

http://www.lids.org/

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 

  

> -----Message d'origine-----
> De : linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] De la part de 
> Timothy Chavez
> Envoyé : vendredi 10 décembre 2004 01:03
> À : linux-kernel@vger.kernel.org
> Cc : serue@us.ltcfwd.linux.ibm.com; sds@epoch.ncsc.mil; 
> rml@novell.com; ttb@tentacle.dhs.org
> Objet : [audit] Upstream solution for auditing file system objects
> 
> Greetings, 
>  
> I'm writing this e-mail to facilitate some discussion on an audit
> feature for inclusion to the mainline kernel's audit subsysystem. 
> I've written out a "brief" description of the problem with some of the
> associated problems it introduces and some of the outlines of
> potential solutions below.  For the most part, the idea stays the
> same, and the mechanism we use to implement it varies.


