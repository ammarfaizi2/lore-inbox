Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRDMMqg>; Fri, 13 Apr 2001 08:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRDMMq1>; Fri, 13 Apr 2001 08:46:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48907 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130466AbRDMMqT>; Fri, 13 Apr 2001 08:46:19 -0400
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
To: andre@linux-ide.org (Andre Hedrick)
Date: Fri, 13 Apr 2001 13:47:15 +0100 (BST)
Cc: george@mvista.com (george anzinger), alan@lxorguk.ukuu.org.uk (Alan Cox),
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.10.10104122102170.4564-100000@master.linux-ide.org> from "Andre Hedrick" at Apr 12, 2001 09:04:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14o2yr-0002n7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Great HZ always defines units of jiffies, but that is worthless if there
> is not a ruleset that tells me a value to divide by to return it to a
> specific quantity of time.

HZ obviously.

Alan

