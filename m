Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTDPMTb (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 08:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTDPMTb 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 08:19:31 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:17306
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S264329AbTDPMT3 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 08:19:29 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Driver for Netgear FA120 USB2 ethernet
References: <yw1x65ped5jv.fsf@zaphod.guide>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 16 Apr 2003 14:30:10 +0200
In-Reply-To: <yw1x65ped5jv.fsf@zaphod.guide>
Message-ID: <yw1x1y02d3ql.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> Is there any chance to get a linux driver for a Netgear FA120 USB2
> ethernet adaptor?  It's got two chips inside.  One is a Realtek
> RTL8201BL and the other an ASIX AX88172.
> 
> /proc/bus/usb/devices:
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  4 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=02(comm.) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=0846 ProdID=1040 Rev= 0.01
> S:  Manufacturer=NETGEAR
> S:  Product=NETGEAR FA120 Adapter
> C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=300mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=(none)
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=128ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Documentation is available:

http://www.asix.com.tw/datasheet/mac/Ax88172.PDF
ftp://152.104.125.40/cn/phy/rtl8201bl/spec-8201bl(120).pdf

Is anyone working on it, or should I do it?  Not that I know how...

-- 
Måns Rullgård
mru@users.sf.net
