Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264519AbRFOUdb>; Fri, 15 Jun 2001 16:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264522AbRFOUdU>; Fri, 15 Jun 2001 16:33:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64519 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264519AbRFOUdK>; Fri, 15 Jun 2001 16:33:10 -0400
Subject: Re: kmallow_maxsize undelcared
To: lee@ricis.com (Lee Leahu)
Date: Fri, 15 Jun 2001 21:32:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, lee@ricis.com, alansz@uic.com
In-Reply-To: <01061515232401.07633@linux> from "Lee Leahu" at Jun 15, 2001 03:23:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15B0GK-00073O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the kmallow_maxsize is reported as undeclared what i try to complile buzz.c
> for the iomega buzz driver in the new kernel 2.4.5.
> 
> how should i fix this?

Either dont compile in buz support or use -ac
