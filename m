Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUHYVeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUHYVeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUHYVdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:33:13 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:33500 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S269157AbUHYVVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:21:22 -0400
Message-ID: <412CF299.2070805@blue-labs.org>
Date: Wed, 25 Aug 2004 16:12:09 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040825
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc1 & iptables (ASSERT net/ipv4/netfilter/ip_nat_helper.c:428
 &ip_nat_lock writelocked)
Content-Type: multipart/mixed;
 boundary="------------060305080203020604000104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060305080203020604000104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I just booted into 2.6.9-rc1.  Dmesg is flooded with this.  Not only 
that, but it stalls the machine until I come back to the keyboard.  Thus 
any network connections timeout.

ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
Hangcheck: hangcheck value past margin!
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked
ASSERT net/ipv4/netfilter/ip_nat_helper.c:428 &ip_nat_lock writelocked


--------------060305080203020604000104
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------060305080203020604000104--
