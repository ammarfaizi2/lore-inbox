Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314011AbSDKG7M>; Thu, 11 Apr 2002 02:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314012AbSDKG7L>; Thu, 11 Apr 2002 02:59:11 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:39633 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S314011AbSDKG7K>; Thu, 11 Apr 2002 02:59:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.5.8-pre3 & ext3: cannot chown
Date: Thu, 11 Apr 2002 08:59:01 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16vYXu-0000HV-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The subject just about says it all.  After 12 hours
of uptime running 2.5.8-pre3 on an ext3 partition,
I noticed that changing the owner of a file had no
effect.  Rebooting with 2.4.18, there was no problem
in using chown.

All the best,

Duncan.
