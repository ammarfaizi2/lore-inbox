Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbTBEAY4>; Tue, 4 Feb 2003 19:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTBEAY4>; Tue, 4 Feb 2003 19:24:56 -0500
Received: from mgw-dax2.ext.nokia.com ([63.78.179.217]:12940 "EHLO
	mgw-dax2.ext.nokia.com") by vger.kernel.org with ESMTP
	id <S267594AbTBEAYz> convert rfc822-to-8bit; Tue, 4 Feb 2003 19:24:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Problems with bootimg (wish to be personally CC'ed the answers/comments posted to the list in response to this posting)
Date: Tue, 4 Feb 2003 16:33:24 -0800
Message-ID: <4D7B558499107545BB45044C63822DDE0219C291@mvebe001.americas.nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with bootimg (wish to be personally CC'ed the answers/comments posted to the list in response to this posting)
Thread-Index: AcLMrjeET9n8QsZyQvaCK8DcnFisbw==
From: <Sowmya.Krishnaswamy@nokia.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Feb 2003 00:33:25.0093 (UTC) FILETIME=[31C16950:01C2CCAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are trying to use bootimg for dual boot: 

# bootimg -f bzImage -n -i ram40.img.gz -v console=ttyS0,115200n8 ramdisk_size=131072 root=/dev/ram

bzImage "2.4.17_MVL21CGENOKIA_4-cpi1-lb-arun (abalasub@mvaserg011) #5 SMP Wed Nov 27 17:27:00 PST 2002"

    1439613 bytes (352 pages) 0x4109cc08-0x411fcc07 -> 0x100000-0x25fff
    16161140 bytes (3946 pages) 0x40131008-0x4109b007 -> 0x8668c-0xff068b
    4096 bytes (1 page) 0x804b908-0x804c907 -> 0x90000-0x90fff

Total 4299 pages, start address is 0x100000

Loading Kernel Image vmlinuz
Running boot code at 0x03011000

SYSTEM STOPS PRINTING MESSAGES AND HANGS. Has anyone faced a similar problem before. Any Suggestions?

Thanks,

Sowmya  

