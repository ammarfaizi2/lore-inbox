Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVCHMxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVCHMxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVCHMwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:52:41 -0500
Received: from web52904.mail.yahoo.com ([206.190.39.181]:35444 "HELO
	web52904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262041AbVCHMwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:52:07 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=vFsgTk+eTeIkTUJWAm0jBzu08OJQl27InoX7h2iVVSTktz+5iX2+QTTfw+wEe73cFv0yey7AjunsMowA4qJJyrgSy6TOoZ5STdWq1KTYgbBmSQA7WIuSqpdRxa9l09ywWmqiZehdvYjnPZI0gOLhb3ePb4rRh7hRiFW50mTsI4c=  ;
Message-ID: <20050308125202.82717.qmail@web52904.mail.yahoo.com>
Date: Tue, 8 Mar 2005 13:52:01 +0100 (CET)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Re: RFD: Kernel release numbering
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
In-Reply-To: <42268037.3040300@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- "Randy.Dunlap" <rddunlap@osdl.org> a écrit : 
> 
> Maybe I don't understand?  Is someone expecting distro
> quality/stability from kernel.org kernels?
> I don't, but maybe I'm one of those minorities.
> 

yes. Some people (like me) would like to use from time to time
 some _new_ stable kernel. It's annoying to see that sometimes
kernel people say that you have a hardware problem in 2.6.0 
release and then the bug is silently fixed in a 2.6.5 release
for example. 

The 2.6 kernel is not good enough for desktop -- sound skips on 
a 700Mhz duron when there is a lot (50M of 256) of free memory 
and mozilla is using CPU. 2.4 with preemptible patches was 
better in that respect.

What i would like to really have is a stable version not a demo
version. I like testing but sometimes i also want stability and
it seems that a good enough 2.6 kernel is still away. 
I don't care how you call it 2.6.x.y.z-rc-kappa i just want to 
be sure that it will not mess up my system. 
(and no, i'm not going to use <insert your favourite distro>
kernel )
 
Just my 2 euro cents (if somebody cares)

P.S. I know this message is late. Sorry if it annoys you.

--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
