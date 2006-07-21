Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWGUEES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWGUEES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 00:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWGUEES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 00:04:18 -0400
Received: from b1C96.static.pacific.net.au ([203.26.9.150]:10501 "HELO
	protocomtech.com.au") by vger.kernel.org with SMTP id S1030452AbWGUEER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 00:04:17 -0400
Message-ID: <44C05234.1020401@protocomtech.com.au>
Date: Fri, 21 Jul 2006 14:04:04 +1000
From: Carlo Sogono <carlosogono@protocomtech.com.au>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rlimit64 on Linux 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: carlosogono@protocomtech.com.au
X-Spam-Processed: protocomtech.com.au, Fri, 21 Jul 2006 14:04:06 +1000
	(not processed: message from valid local sender)
X-Return-Path: carlosogono@protocomtech.com.au
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: protocomtech.com.au, Fri, 21 Jul 2006 14:04:07 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC to my personal email carlosogono@protocomtech.com.au

I would like to find out if rlimit64 is supported by Linux 2.6. It 
doesn't seem to be supported by 2.4, the default kernel for RHEL3. I 
also cannot seem to find any specific information regarding 64-bit 
rlimit anywhere on the net, except a 3-year old page saying rlimit64 is 
not implemented properly.

I am in need of using 64-bit values for rlimit and if Linux doesn't, 
which UNIX system (preferably OSS) would anyone consider as having a 
stable implementation of it.

Regards,
Carlo







-- 
Carlo Sogono
Software Engineer

Protocom Technology Pty Ltd
Level 4, 447 Kent St
Sydney, NSW 2000
AUSTRALIA

Website : http://www.protocomtech.com.au
Email   : carlo@protocomtech.com.au
Phone   : +61 2 9264 1316
Fax     : +61 2 9264 1915
Mobile  : +61 403 061719

----------------------------------------------------------------------
This email and any files transmitted with it are confidential and may
contain privileged or copyright information. If you are not the named
addressee you should not disseminate, distribute or copy this e-mail.
Please notify the sender immediately if you have received this e-mail
by mistake and delete this e-mail from your system. We do not
guarantee that this material is free from viruses or any other
defects although due care has been taken to minimise the risk. Any
views expressed in this message are those of the individual sender,
except where the sender specifically states them to be the views of
Protocom Technology Pty Ltd.
----------------------------------------------------------------------


