Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbTBVDAV>; Fri, 21 Feb 2003 22:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267783AbTBVDAV>; Fri, 21 Feb 2003 22:00:21 -0500
Received: from mpls-qmqp-01.inet.qwest.net ([63.231.195.112]:17930 "HELO
	mpls-qmqp-01.inet.qwest.net") by vger.kernel.org with SMTP
	id <S267782AbTBVDAU>; Fri, 21 Feb 2003 22:00:20 -0500
Date: Fri, 21 Feb 2003 19:10:02 -0800
Message-ID: <3E56EA0A.1000608@i-55.com>
From: "Leslie Donaldson" <donaldlf@i-55.com>
To: axp-kernel-list@redhat.com
Cc: linux-kernel@vger.kernel.org
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:1.3a) Gecko/20030120
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: 2.5.62 alpha
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   Finally go modules to work, Update to the latest before compiling.


Per Jan-Benedict Glaw
 > I don't know how good/bad this combination of gcc and binutils is for
 > 2.5.x, but modutils 2.4.22 will _not_ work with current 2.5.x. > >
 > Therefor,
 > you need the new module-init-tools, available at
 > ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules IIRC.


bad news. The reisrfs started tried allocate an page of memory to
recover transactions and boom, kernel droped core and apples
fell everywhere.

mm/page if I remember correctly.

Leslie Donaldson


-- 
/----------------------------\ Current Contractor: None
|    Leslie F. Donaldson     | Current Customer  : None
|    Computer Contractor     | Skills: 
Unix/OS9/VMS/Linux/SUN-OS/C/C++/assembly
| Have Computer will travel. | WWW  : 
http://www.cs.rose-hulman.edu/~donaldlf
\----------------------------/ Email: mail://donaldlf@cs.rose-hulman.edu
Goth Code V1.1: GoCS$$ TYg(T6,T9) B11Bk!^1 C6b-- P0(1,7) M+ a24 n--- b++:+
                 H6'11" g m---- w+ r+++ D--~!% h+ s10 k+++ R-- Ssw LusCA++

