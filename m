Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277233AbRJDVHw>; Thu, 4 Oct 2001 17:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277226AbRJDVHm>; Thu, 4 Oct 2001 17:07:42 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65039 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277224AbRJDVHa>; Thu, 4 Oct 2001 17:07:30 -0400
Subject: Re: CPU Temperature?
To: harri@synopsys.COM
Date: Thu, 4 Oct 2001 22:13:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BBB4011.C4DC2527@Synopsys.COM> from "Harald Dunkel" at Oct 03, 2001 06:42:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pFns-0004DA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a standard interface to watch the temperature of the CPU (e.g.
> Athlon Thunderbird)? Or is this a feature of my main board?

Generally it comes from the mainboard
 
> How can I access the CPU temperature, fan speed etc. from Linux?
> Or is this too hardware dependent to implement a common interface?

lm-sensors - it works well. Its shipped in some vendor trees
