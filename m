Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLLM5V>; Tue, 12 Dec 2000 07:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLLM5L>; Tue, 12 Dec 2000 07:57:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1797 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129401AbQLLM5C>; Tue, 12 Dec 2000 07:57:02 -0500
Subject: Re: Linux 2.2.18 release notes
To: peter@cadcamlab.org (Peter Samuelson)
Date: Tue, 12 Dec 2000 12:28:41 +0000 (GMT)
Cc: android@abac.com (Android), linux-kernel@vger.kernel.org
In-Reply-To: <20001211233956.F3199@cadcamlab.org> from "Peter Samuelson" at Dec 11, 2000 11:39:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145oXz-00017m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - maybe they'll need to patch lm_sensors to accommodate the increased
>   temperature range since the P4 runs so hot. (: (:

Also there is a new 'rep nop' instruction that means 'short pause' and is
used in spinlocks. 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
