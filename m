Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbTFUGdT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 02:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbTFUGdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 02:33:18 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:36368 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265002AbTFUGdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 02:33:17 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71-mm1 PCMCIA Yenta socket nonfunctional
Date: Sat, 21 Jun 2003 11:31:02 +0800
User-Agent: KMail/1.5.2
References: <200306161343.03663.mflt1@micrologica.com.hk> <20030616082549.B5004@flint.arm.linux.org.uk> <200306161848.38745.mflt1@micrologica.com.hk>
In-Reply-To: <200306161848.38745.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306202004.00191.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 June 2003 18:48, Michael Frank wrote:
>
> Why must start cardmgr manualy now?

Fixed in 2.5.72-mm2

Regards
Michael
-- 
Powered by linux-2.5.72-mm2, compiled with gcc-2.95-3 because it's rock solid

My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Learning 2.5 kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 serial and ide drivers, ACPI, S3

The 2.5 kernel could use your usage. More info on setting it up at
http://www.codemonkey.org.uk/post-halloween-2.5.txt


