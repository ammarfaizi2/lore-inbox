Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310122AbSCABHS>; Thu, 28 Feb 2002 20:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310237AbSCABD5>; Thu, 28 Feb 2002 20:03:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48400 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310277AbSCAA6f>; Thu, 28 Feb 2002 19:58:35 -0500
Subject: Re: Congrats Marcelo,
To: davej@suse.de (Dave Jones)
Date: Fri, 1 Mar 2002 01:13:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        jdennis@snapserver.com (Dennis Jim),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <Pine.LNX.4.33.0203010137090.8089-100000@Appserv.suse.de> from "Dave Jones" at Mar 01, 2002 01:37:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gbbh-0001tN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The machines in question are all IBMs iirc ? Could we work around
> this with DMI strings for the suspect laptops ?

DMI can help in a much more productive way. DMI tells you the type of 
sensor in the machine. Once you are using ACPI though you talk to ACPI
and it talks to the smbus etc and knows whats in the box
