Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284049AbRLELHU>; Wed, 5 Dec 2001 06:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284051AbRLELHJ>; Wed, 5 Dec 2001 06:07:09 -0500
Received: from relay03.cablecom.net ([62.2.33.103]:52767 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S284045AbRLELG5>; Wed, 5 Dec 2001 06:06:57 -0500
Message-Id: <200112051106.fB5B6VQ24498@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: LLX <llx@swissonline.ch>
Reply-To: llx@swissonline.ch
To: linux-kernel@vger.kernel.org
Subject: raw devices & software raid 
Date: Wed, 5 Dec 2001 12:06:11 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i want to create a raid devices with raid 
level 0 that does raw i/o. 

is this possible and if do i have to make 
the md device a raw device or the disk
it is built of?

