Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265300AbUFTRUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbUFTRUg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUFTRUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:20:35 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:34971 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265300AbUFTRU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:20:26 -0400
Message-ID: <40D5C782.5060702@blue-labs.org>
Date: Sun, 20 Jun 2004 13:21:06 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.7, more build warnings, SCTP, x86_64
Content-Type: multipart/mixed;
 boundary="------------000209060803090106090909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000209060803090106090909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  CC      net/sctp/sm_make_chunk.o
net/sctp/sm_make_chunk.c: In function `sctp_process_init':
net/sctp/sm_make_chunk.c:1849: warning: cast to pointer from integer of 
different size
net/sctp/sm_make_chunk.c:1851: warning: cast from pointer to integer of 
different size

  CC      net/sctp/socket.o
net/sctp/socket.c: In function `sctp_id2assoc':
net/sctp/socket.c:142: warning: cast from pointer to integer of 
different size


--------------000209060803090106090909
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


--------------000209060803090106090909--
