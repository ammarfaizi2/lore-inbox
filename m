Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265599AbRGDHDV>; Wed, 4 Jul 2001 03:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265626AbRGDHDL>; Wed, 4 Jul 2001 03:03:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13582 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265599AbRGDHCz>; Wed, 4 Jul 2001 03:02:55 -0400
Subject: Re: [PATCH] update for ALi Audio Driver
To: Matt_Wu@acersoftech.com.cn
Date: Wed, 4 Jul 2001 08:02:14 +0100 (BST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <48256A7F.00217B73.00@cnshans1.acersoftech.com.cn> from "Matt_Wu@acersoftech.com.cn" at Jul 04, 2001 02:12:45 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Hgfu-0000Up-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts important changes that are required for example for the trident
audio built into the Alpha, or for using trident based audio with non
x86 processors. 

Please sort out which are your actual changes and what is reverting other
important stuff

Alan

