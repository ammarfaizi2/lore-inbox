Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283597AbRK3KwE>; Fri, 30 Nov 2001 05:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283599AbRK3Kvy>; Fri, 30 Nov 2001 05:51:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8207 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283597AbRK3Kvi>; Fri, 30 Nov 2001 05:51:38 -0500
Subject: Re: 32 bit UIDs on 2.4.14
To: jose@iteso.mx
Date: Fri, 30 Nov 2001 10:59:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0111292002540.29568-100000@iteso.mx> from "jose@iteso.mx" at Nov 29, 2001 08:06:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169lOX-00035g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   What is the trick to get more than 2^16 uids working on all services?=
> ?

2.4.x kernel
Glibc 2.2
Up to date pam modules
ext2/ext3 file system

patches needed for quotas

