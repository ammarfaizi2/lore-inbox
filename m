Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267879AbRHIJZW>; Thu, 9 Aug 2001 05:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269115AbRHIJZN>; Thu, 9 Aug 2001 05:25:13 -0400
Received: from [216.52.49.36] ([216.52.49.36]:2056 "HELO bosvwl02")
	by vger.kernel.org with SMTP id <S267879AbRHIJZG> convert rfc822-to-8bit;
	Thu, 9 Aug 2001 05:25:06 -0400
content-class: urn:content-classes:message
Subject: procfs doubts 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 9 Aug 2001 14:53:04 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Message-ID: <B10DD1F99B22C844BC146F2C66BF17F813AD8C@punmsg01.ad.infosys.com>
Thread-Topic: proc file system
Thread-Index: AcEf2Crbi0OmM4uqEdWQWABQixLf9wACd35QADUPVWA=
From: "Dattatray Kulkarni" <dattatray_kulkarni@infy.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Aug 2001 09:23:04.0504 (UTC) FILETIME=[E4A0F380:01C120B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have some doubts regarding proc file system in linux.
1. read_proc & get_info have similar functionality. when i do cat
/proc/net/some_procfile, read_info function is called. then how & when
get_info function is called?
2. What is the exact difference between proc_create_entry &
proc_register?  Is it necessary to write both of these functions?
3 . How the function write_proc works? and when that function is called
by the kernel?
regards,
dattatray.


