Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSCRLXT>; Mon, 18 Mar 2002 06:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSCRLXA>; Mon, 18 Mar 2002 06:23:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58635 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292982AbSCRLWx>; Mon, 18 Mar 2002 06:22:53 -0500
Subject: Re: Another entry for the MCE-hang list
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Mon, 18 Mar 2002 11:38:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203180546.g2I5kP412586@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Mar 17, 2002 10:46:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mvTW-0004qK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Hi, all. I just booted 2.4.19-pre3, and it hung right after the MCE
> message. This is an Asus P2B-D with two Intel 450 MHz PIII's. Output
> of /proc/cpuinfo appended.

See linux-kernel for the past week. Its been discussed repeatedly. Pre3 only
works on non intel chips unless you kill MCE support
