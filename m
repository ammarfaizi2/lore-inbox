Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271687AbRHQQg1>; Fri, 17 Aug 2001 12:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271684AbRHQQgQ>; Fri, 17 Aug 2001 12:36:16 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:15421 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id <S271685AbRHQQgF>;
	Fri, 17 Aug 2001 12:36:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Peter Klotz <peter.klotz@aon.at>
To: linux-kernel@vger.kernel.org
Subject: Error on fs unmount
Date: Fri, 17 Aug 2001 18:39:08 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01081718390800.01143@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi developers

Kernel 2.4.8 produces the following message on almost every shutdown:

Unmounting filesystems: Trying to _clear_inode of system file 9! Shouldn't 
happen.

This did not occur in 2.4.6 and prior.

Is this an issue?

Please CC to me since I am not on the list.

Bye, Peter.
