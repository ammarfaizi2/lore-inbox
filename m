Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264979AbUFTRQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbUFTRQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUFTRQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:16:57 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:15001 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264979AbUFTRQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:16:53 -0400
Message-ID: <40D5C6A9.7080600@blue-labs.org>
Date: Sun, 20 Jun 2004 13:17:29 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ia32 'comparison is always false' comment
Content-Type: multipart/mixed;
 boundary="------------070300060906060001030304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070300060906060001030304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Just an fyi for whomever is interested - 2.6.7 on x86_64.

  CC      arch/x86_64/ia32/ia32_binfmt.o
In file included from arch/x86_64/ia32/ia32_binfmt.c:306:
fs/binfmt_elf.c: In function `load_elf_interp':
fs/binfmt_elf.c:371: warning: comparison is always false due to limited 
range of data type
In file included from arch/x86_64/ia32/ia32_binfmt.c:306:
fs/binfmt_elf.c: In function `load_elf32_binary':
fs/binfmt_elf.c:783: warning: comparison is always false due to limited 
range of data type


--------------070300060906060001030304
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


--------------070300060906060001030304--
