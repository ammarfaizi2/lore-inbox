Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSLCUcD>; Tue, 3 Dec 2002 15:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbSLCUcD>; Tue, 3 Dec 2002 15:32:03 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:53450 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265643AbSLCUcC>; Tue, 3 Dec 2002 15:32:02 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Reserving physical memory at boot time
Date: Tue, 3 Dec 2002 13:03:16 +0100
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212031303.16487.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to reserve a particular page of physical memory when
the kernel boots.  By reserving I mean that no one else gets to read
from it or write to it: it is mine.  Any suggestions for the best way
to go about this with a 2.5 kernel?

Thanks,

Duncan.
