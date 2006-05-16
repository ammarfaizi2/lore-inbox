Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWEPVmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWEPVmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWEPVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:42:21 -0400
Received: from web26611.mail.ukl.yahoo.com ([217.146.177.63]:43874 "HELO
	web26611.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932187AbWEPVlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:41:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=eyYdcpYtthont7wK9NUbLx5Z9ki21ai3f34jvpl6pqKG+D0myQp8h6TvBmMDyTEDI4ieCGon2lxOmwU6xKp/76FHOd5SBRj5GyZlLyyw27Z5pjiV1glQ/r/yVWx/KYybYO1+mJYd4EiA/qY06siSeN69wpTuftIPvUAFKuhiATA=  ;
Message-ID: <20060516214148.14432.qmail@web26611.mail.ukl.yahoo.com>
Date: Tue, 16 May 2006 23:41:48 +0200 (CEST)
From: linux cbon <linuxcbon@yahoo.fr>
Subject: replacing X Window System !
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I know it may not be the best place, sorry for that.

X Window System is old, not optimized, slow, not
secure (uses root much), accesses the video hardware
directly (thats the kernel's job !), it cannot do VNC,
etc.

The question is : what are your ideas to make a system
remplacing X Window System ?

I think that linux kernel should contain a very basic
and universal Window System module (which could also
work on Unixes and BSDs) to replace X, X.org etc.

What do you think about this ?

Thanks









	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
