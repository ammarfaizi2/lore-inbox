Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132227AbRCVXAj>; Thu, 22 Mar 2001 18:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132228AbRCVXAT>; Thu, 22 Mar 2001 18:00:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24842 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132227AbRCVXAM>; Thu, 22 Mar 2001 18:00:12 -0500
Subject: Re: [CHECKER] 8 more potential locking problems
To: acc@CS.Stanford.EDU
Date: Thu, 22 Mar 2001 23:01:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
In-Reply-To: <20010322141059.A21490@Xenon.Stanford.EDU> from "Andy Chou" at Mar 22, 2001 02:10:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gE5P-0003V6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We modified our compiler extension for checking lock consistency and
> found 8 more potential errors.

All 8 are real, all 8 fixed in my tree. 

