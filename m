Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWIQUDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWIQUDl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 16:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWIQUDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 16:03:41 -0400
Received: from outmx014.isp.belgacom.be ([195.238.4.69]:20107 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932387AbWIQUDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 16:03:40 -0400
Message-ID: <450DAA2C.5090806@trollprod.org>
Date: Sun, 17 Sep 2006 22:03:56 +0200
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Thunderbird 2.0b1pre (X11/20060916)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: APIC on Asus M2N SLI Deluxe
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beta BIOS 706 runs fine on my system.


 >Hi Thomas,
 >
 >> recently, I tried to upgrade the bios of the ASUS M2N SLI Deluxe
 >> board from release 0202 to 0307. With the 0307 bios, I get a kernel
 >> panic that the APIC cannot be found. Concerning this, I've two
 >> explanations, could possibly confirm someone here this:
 >
 >I can confim this problem.
 >
 >I think Asus screwed up the bios...
 >
 >> It's not a major problem for me right now, the 0202 bios works like
 >> a charm with the 2.6.17.8 kernel. I'm just curious.
 >
 >I need Wake-On-LAN and that doesn't work with 0202 and is fixed with 
 >0307. I
 >boot the system with the noapic option.
 >
 >Kind regards,
 >
 >Gerd
