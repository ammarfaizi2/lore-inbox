Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135716AbRDSVg1>; Thu, 19 Apr 2001 17:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135721AbRDSVgR>; Thu, 19 Apr 2001 17:36:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14096 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135716AbRDSVgB>; Thu, 19 Apr 2001 17:36:01 -0400
Subject: Re: FW: Linux 2.4.3 Compile Errors - Power Mac
To: jeff.galloway@rundog.com (Jeff Galloway)
Date: Thu, 19 Apr 2001 22:37:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <B704C0AA.4239%jeff.galloway@rundog.com> from "Jeff Galloway" at Apr 19, 2001 04:19:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qM73-00088z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I sent this report to the people indicated below, whose names I got from the
> MAINTAINERS file in the 2.4.3 distribution, but the email address for Mr.
> MacKerras is no longer good and Mr. Chastain wrote me back that he is not
> following 2.4 issues.

Well Keith is on holiday I believe and Paul is moving from Linuxcare.

> Any suggestions on the solution to my problem?

Build PPC from the linuxppc trees not the base one - it isnt yet all nicely
merged in 2.4
