Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbUKSJTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbUKSJTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 04:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUKSJSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 04:18:50 -0500
Received: from web90006.mail.scd.yahoo.com ([66.218.94.64]:13238 "HELO
	web90006.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S261325AbUKSJMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 04:12:53 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=r2ss6DyFSZW4pNWZnOzpVvEmYp5BWmGw5j6Tj/QPKLA2RA5oCWbyjIvmq3RX35zqu/gXgz29HMSQd6hSJffNJO2N3sjDNeEYevbvKHpUn7zIu3Ehi0755W0CSVz02n3Lz4GDK10RlS3sJOL6jKndJBsw6B5ex2No/psAD/MBOVY=  ;
Message-ID: <20041119091240.4927.qmail@web90006.mail.scd.yahoo.com>
Date: Fri, 19 Nov 2004 01:12:40 -0800 (PST)
From: linux dude <dude_linux@yahoo.com>
Subject: 2.6.9
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Gurus,

I am new to linux kernel, trying to work on my
academic
project. 

I have one basic question:

I downloaded latest 2.6.9 kernel. Compiled it and 
did make modules, make modules_install. Then I 
upgraded the grub. Everything was OK till:

When I tried to reboot with 2.6.9 kernel, it was
trying
load 2.6.4-52/.../reiserfs.ko and failing.

My question is I already did make odlconfig;make;make
modules;make modules_install; updated grub,image,
system.map. Is there any thing missing because of
which
it is trying to load module from old
/lib/modules/2.6.4-52/....
And Why it is not picking up from 2.6.9/.../ .

Any help would be really appriciated.

Please mail me at dude_linux@yahoo.com as I did't
subscribe.

Regards
Dude_linux.





		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

