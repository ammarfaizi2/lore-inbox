Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbWBQUaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWBQUaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWBQUaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:30:15 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:3019 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1751716AbWBQUaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:30:14 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcY0APHHHI7HTYZWSnCOZTgvBvsSIw==
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43F6324D.3040206@bfh.ch>
Date: Fri, 17 Feb 2006 21:30:05 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: C/H/S from user space
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 20:30:08.0278 (UTC) FILETIME=[F17CF360:01C63400]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<snip>

wow this is really great... but just for your information
on my ibm notebook the output is this:

        Disk parameter table(s) at vector 0x41
Disk0
    Cylinders = 1024
      Sectors = 63
        Heads = 240
Write precomp = 255
 Landing zone = 65296
        Reserved bit 0 set
        Reserved bit 1 set
        Reserved bit 2 set
        More than 8 heads
        Reserved bit 4 set
        Defect map present
        Disable retries
        Disable retries
Disk1
    Cylinders = 1024
      Sectors = 4
        Heads = 16
Write precomp = 0
 Landing zone = 0
        Disk parameter table(s) at vector 0x46
Disk0
    Cylinders = 34281
      Sectors = 240
        Heads = 230
Write precomp = 7950
 Landing zone = 61
        Reserved bit 2 set
        More than 8 heads
        Disable retries
Disk1
    Cylinders = 47631
      Sectors = 102
        Heads = 46
Write precomp = 3698
 Landing zone = 7952
        More than 8 heads
        Defect map present
        Disable retries


Just Note the "MAX" of 240 heads (very typical for IBM notebooks).

But anyway this tool is very useful for me. many, many thanks.


