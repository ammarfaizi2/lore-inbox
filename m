Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVAMXOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVAMXOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVAMXN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:13:58 -0500
Received: from mail8.spymac.net ([195.225.149.8]:50666 "EHLO mail8")
	by vger.kernel.org with ESMTP id S261816AbVAMXNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:13:14 -0500
Message-ID: <41E7008B.1070703@spymac.com>
Date: Thu, 13 Jan 2005 23:13:15 +0000
From: surya <surya_prabhakar@spymac.com>
Reply-To: surya_prabhakar@spymac.com
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sysctl related ............
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list ,
     Do we have any sysctl in linux which is equal to  
/tcp_ip_abort_interval/ in HP

Typically in HP we issue it as below

//usr/sbin/ndd -set /dev/tcp tcp_ip_abort_interval <value>/

how do we do it in linux .I could not find anything relevant in //proc/sys/net/ipv4/*/ directory or in the man of tcp .

thanks.


Regards
Surya


