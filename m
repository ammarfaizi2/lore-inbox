Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUGYT3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUGYT3E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 15:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUGYT3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 15:29:04 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:62154 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264297AbUGYT3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 15:29:00 -0400
Message-ID: <41040A4B.6080703@blue-labs.org>
Date: Sun, 25 Jul 2004 15:30:19 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040724
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: cdrom: dropping to single frame dma
Content-Type: multipart/mixed;
 boundary="------------090000050209060207000101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090000050209060207000101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've been trying to rip my CDs onto my HD, and last night after about 7 
CDs I realized I was getting junk and it was taking forever to rip a 
CD.  I'm using 2.6.8-rc2 and I have two different CD-ROMs in my 
machine.  Both are burners.

I got a single "cdrom: dropping to single frame dma" message which 
according to my research is part of the culprit.

See the thread on LKML back on 5/15/2004 titled "dma ripping", and again 
on 6/15 titled "cdrom ripping / dropping to dingle frame dma" -- yes 
that's a "d".

I'm guessing that Jens' patch for this didn't make it into the kernel.

David




--------------090000050209060207000101
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


--------------090000050209060207000101--
