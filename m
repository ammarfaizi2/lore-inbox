Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310368AbSBRKB2>; Mon, 18 Feb 2002 05:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310371AbSBRKBT>; Mon, 18 Feb 2002 05:01:19 -0500
Received: from mail1.tinet.ie ([159.134.237.19]:20544 "EHLO mcclure.tinet.ie")
	by vger.kernel.org with ESMTP id <S310368AbSBRKBL>;
	Mon, 18 Feb 2002 05:01:11 -0500
From: "John Brosnan" <brosnans1@eircom.net>
To: linux-kernel@vger.kernel.org
Subject: ARP timeout value, why 1 minute ?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-Originating-IP: 193.120.151.1
X-Mailer: Eircom Net CRC Webmail (http://www.eircom.net/)
Organization: Eircom Net (http://www.eircom.net/)
Message-Id: <E16ckba-0001mi-00@mcclure.tinet.ie>
Date: Mon, 18 Feb 2002 10:01:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I may not be correct but isn't the traditional ARP timeout value 20 minutes in many Unix versions such as BSD, freeBSD 
and early version of Linux. But from a certain point, Linux(only?) changed from 20 minutes to one minute. This changes the system configuration to shorten the ARP expiration timer to one minute instead of the default 20 minutes. 

Why was it changed to 1 minute ? 

thanks in advance, 

John. 

