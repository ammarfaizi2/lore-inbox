Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUDNP2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUDNP1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:27:44 -0400
Received: from web41414.mail.yahoo.com ([66.218.93.80]:17566 "HELO
	web41414.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264271AbUDNP0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:26:52 -0400
Message-ID: <20040414152643.62896.qmail@web41414.mail.yahoo.com>
Date: Wed, 14 Apr 2004 08:26:43 -0700 (PDT)
From: Parag Nemade <cranium2003@yahoo.com>
Subject: Basic understanding about sk_buff packet handling
To: kernerl mail <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
              As a part of my kernel project i come to
some problems regarding sk_buff structure
1) i want to add two fields of each 4 bytes in sk_buff
structure what is the effect of it on kernel packet
processing? Is there any -ve effect?
2) if i am going to increase it by 8 bytes then what
will happen to net packet size and its data part? Is
that all will fit in sk_buff?
3) Which is best to include my 2 fields in sk_buff or
include its total value at end of data part?
4) When kernel passes the packet to dest host all
sk_buff fields are also transferred or only packet
header and data?
parag.




	
		
__________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online by April 15th
http://taxes.yahoo.com/filing.html
