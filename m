Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313913AbSDPVKO>; Tue, 16 Apr 2002 17:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313911AbSDPVKN>; Tue, 16 Apr 2002 17:10:13 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:35159 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S313913AbSDPVKM> convert rfc822-to-8bit; Tue, 16 Apr 2002 17:10:12 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Christian =?iso-8859-15?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: smbfs 2.4.19pre6
Date: Tue, 16 Apr 2002 23:10:09 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204162310.09755.linux-kernel@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I have a smbfs mounted samba-share that got lost due to a network error.

Every process accessing the mount point falls into uniterruptable sleep - till 
the reboot. Even a lsof is frozen. 

Is this a bug or a known issue?

greetings

Christian

