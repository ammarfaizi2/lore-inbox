Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSJIRAp>; Wed, 9 Oct 2002 13:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbSJIRAo>; Wed, 9 Oct 2002 13:00:44 -0400
Received: from members.cotse.com ([216.112.42.58]:63625 "EHLO cotse.com")
	by vger.kernel.org with ESMTP id <S261847AbSJIRAn>;
	Wed, 9 Oct 2002 13:00:43 -0400
Message-ID: <YWxhbg==.35e5d37d477d0ddc01cb3484f9ef3349@1034183288.cotse.net>
Date: Wed, 9 Oct 2002 13:08:08 -0400 (EDT)
X-Abuse-To: abuse@cotse.com
X-AntiForge: http://packetderm.cotse.com/antiforge.php
Subject: Patches from Redhat gcc 3.2
From: "Alan Willis" <alan@cotse.net>
To: <phil-list@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: alan@cotse.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Which of the 69 patches in the redhat gcc-3.2 rpm from RH8 provide the
functionality needed for the __thread keyword, and anything else needed for
nptl to work correctly.  Also, are any modifications needed to glibc 2.3?
Also, I do not wish to make my system unusable with 2.4.x kernels,.. if I
build glibc with --enable-kernel=current, will that make glibc unusable with
2.4.x kernels?  I've been using 2.5 for a while now,. but I do want a sane
recourse.  Is this line also correct: --enable-addons=nptl,nptl_db, where
I've untarred the nptl dirs under in the main glibc directory.

   I'm trying to set up an environment where I can use nptl on gentoo.

Any assistance is most welcome :o)

Thanks in advance,

-alan


