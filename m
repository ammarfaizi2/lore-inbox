Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310806AbSDUGc5>; Sun, 21 Apr 2002 02:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310979AbSDUGc4>; Sun, 21 Apr 2002 02:32:56 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:58777 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S310806AbSDUGcy>; Sun, 21 Apr 2002 02:32:54 -0400
Date: Sat, 20 Apr 2002 23:53:48 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: Novell ZenWorks and the GPL 
Message-ID: <20020420235348.A11687@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linux/GPL folks,

I have completed my review of Novell's latest NSS File System 
(which I am busily reverese engineering) and their Novell Zenworks 
management platform, and have come across an item I feel obligated 
to report.

Novell is apparantly using a stripped down Linux kernel to provide the 
imaging capability for their latest Zenworks release.  I have spoken
to several Novell customers who verified Novell has admited to using
Linux as their imaging "engine" to install remote W2K and NetWare 
server images to computers loaded with Zenworks.  Reverse compile
of the software also leads me to believe they have modified NWFS
and are using it as well.  I must say I am pleased to see Novell
take such an active and pro-Linux stance and actually use Linux 
in a shipping product.

Unfortunately, I am completely unable to locate the source code 
with all the wonderful fixes, enhancements, and new features
they have obviously added to enable this level of capability.  Unless
I am mistaken, Novell is obligated to repost the full source code.
I will analyze and look over their website more closely, and it may 
perhaps be I have missed the whereabouts of the source modules
in question.  

Is anyone else aware of Novell shipping a Linux kernel as the core 
engine in Zenworks?  

Very Truly Yours

:-)

Jeff V. Merkey

