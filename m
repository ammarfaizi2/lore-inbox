Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUFKAg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUFKAg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUFKAg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 20:36:26 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:36005 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S263640AbUFKAgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 20:36:00 -0400
Message-ID: <40C8FE7C.2060404@blue-labs.org>
Date: Thu, 10 Jun 2004 20:36:12 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040609
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alsa-user@lists.sourceforge.net
Subject: ALSA burps, 2.6.7-rc2 VIA VT8233
Content-Type: multipart/mixed;
 boundary="------------080509040907040402060507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080509040907040402060507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This machine spams dmesg _very_ frequently with the following message:

    ALSA sound/pci/via82xx.c:737: invalid via82xx_cur_ptr, using last 
valid pointer

It doesn't happen constantly but comes in bursts.  I haven't any idea 
what triggers it since I can be playing 20 minutes without any messages 
then there will be 50 of them with no change in computer usage.

David


--------------080509040907040402060507
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


--------------080509040907040402060507--
