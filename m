Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbSLOMQA>; Sun, 15 Dec 2002 07:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbSLOMQA>; Sun, 15 Dec 2002 07:16:00 -0500
Received: from nwusr-21929.dial-in.ttnet.net.tr ([195.175.165.170]:1152 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266434AbSLOMP7> convert rfc822-to-8bit; Sun, 15 Dec 2002 07:15:59 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Tarkan Erimer <tarkane@solmaz.com.tr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PROBLEM]: "make rpm" fails on RH 8.0
Date: Sun, 15 Dec 2002 14:17:34 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212151417.34213.tarkane@solmaz.com.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I try to make kernel rpms via "make rpm" command but,  it fails to build.
Because, In RH 8.0, build options of rpm moved to "rpmbuild" command, instead 
of "rpm" command. I think,some modifications to kernel build process will be 
required to fix it.


Greetz!

Tarkan Erimer

