Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292829AbSCRLcJ>; Mon, 18 Mar 2002 06:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSCRLbu>; Mon, 18 Mar 2002 06:31:50 -0500
Received: from f184.law7.hotmail.com ([216.33.237.184]:9229 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S292829AbSCRLbi>;
	Mon, 18 Mar 2002 06:31:38 -0500
X-Originating-IP: [172.139.57.60]
From: "Nayyer Tiger" <tigerkhan_1@hotmail.com>
To: faheemullahkhan101@aol.com, zohair420@hotmail.com, danish4000@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help
Date: Mon, 18 Mar 2002 15:31:32 +0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F184dEXWU5oIvIZZwmo0000bd87@hotmail.com>
X-OriginalArrivalTime: 18 Mar 2002 11:31:33.0211 (UTC) FILETIME=[74AB0AB0:01C1CE70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I see that in the very latest Configure.help version, 2.76, available at 
http:/www.tuxedo.org/~esr/cml2/
Eric has decided to follow the following standard:
IEC 60027-2, Second edition, 2000-11, Letter symbols to be used in 
electrical technology - Part 2: Telecommunications and electronics.
and has changed all the abbreviations for Kilobyte (KB) to KiB, Megabyte 
(MB) to MiB, etc, etc.

Now, granted that this is the "standard", should there be some discussion 
related to this
change, or is everyone comfortable with this?  It certainly made me do a 
double take.

Here is a snippet from the diff between versions 2.75 and 2.76 of 
Configure.help:

@@ -344,8 +344,8 @@
   If you are compiling a kernel which will never run on a machine with
   more than 960 megabytes of total physical RAM, answer "off" here
   (default choice and suitable for most users). This will result in a
-  "3GB/1GB" split: 3GB are mapped so that each process sees a 3GB
-  virtual memory space and the remaining part of the 4GB virtual memory
+  "3GiB/1GiB" split: 3GiB are mapped so that each process sees a 3GiB
+  virtual memory space and the remaining part of the 4GiB virtual memory
   space is used by the kernel to permanently map as much physical memory
   as possible.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.

