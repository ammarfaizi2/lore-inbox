Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310695AbSCMQEf>; Wed, 13 Mar 2002 11:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310703AbSCMQEZ>; Wed, 13 Mar 2002 11:04:25 -0500
Received: from ns1.advfn.com ([212.161.99.144]:32008 "EHLO mail.advfn.com")
	by vger.kernel.org with ESMTP id <S310695AbSCMQEX>;
	Wed, 13 Mar 2002 11:04:23 -0500
Message-Id: <200203131604.g2DG4Ls23185@mail.advfn.com>
Content-Type: text/plain; charset=US-ASCII
From: Tim Kay <timk@advfn.com>
Reply-To: timk@advfn.com
Organization: Advfn.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IO-APIC reports this may help?
Date: Wed, 13 Mar 2002 16:05:58 +0000
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	just a quickie, our Dell Poweredge boxes - Serverworks motherboard - are 
continually pumping out IO-APIC errors as I've reported here before, we have 
three of the same boxes running FreeBSD (limitless file descriptors per 
process - sorry, we need it!) and I've just noticed that dmesg on these says 
that:

IO APIC - APIC_IO: Testing 8254 interrupt delivery
APIC_IO: Broken MP table detected: 8254 is not connected to IOAPIC #0 intpin 
2 
APIC_IO: routing 8254 via 8259 and IOAPIC #0 intpin 0 

Does this help anyone diagnose the error??

Best of luck,

Tim

-- 
----------------
Tim Kay
systems administrator
Advfn.com Plc - http://www.advfn.com/
timk@advfn.com
Tel: 020 7070 0941
Fax: 020 7070 0959
