Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132497AbRDCTN4>; Tue, 3 Apr 2001 15:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132465AbRDCTNr>; Tue, 3 Apr 2001 15:13:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25608 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132560AbRDCTNh>; Tue, 3 Apr 2001 15:13:37 -0400
Subject: Re: /proc/config idea
To: ben@kalifornia.com (Ben Ford)
Date: Tue, 3 Apr 2001 20:11:55 +0100 (BST)
Cc: jamagallon@able.es (J . A . Magallon), dlang@diginsite.com (David Lang),
        linux-kernel@vger.kernel.org
In-Reply-To: <3ACA1A91.70401@kalifornia.com> from "Ben Ford" at Apr 03, 2001 11:46:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kWDf-0000Ez-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That would be great and all, but can you tell me how to do it when I 
> have 3 or 4 different compiles of the same kernel version?

Each compile you do already gets assigned a version #, if thats not enough then
add your own id string
