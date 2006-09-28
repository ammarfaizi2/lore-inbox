Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751896AbWI1NkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbWI1NkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbWI1NkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:40:00 -0400
Received: from ms3.nsysu.edu.tw ([140.117.11.143]:64976 "EHLO ms3.nsysu.edu.tw")
	by vger.kernel.org with ESMTP id S1751896AbWI1Nj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:39:59 -0400
X-Spam-Score: -101.215
Message-ID: <000301c6e303$72a12bd0$8f9c758c@shuming>
From: "Shu-Ming" <m943010036@student.nsysu.edu.tw>
To: <linux-kernel@vger.kernel.org>
Subject: The structure of __ksymtab and __ksymtab_gpl?
Date: Thu, 28 Sep 2006 21:38:56 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

What is the the structure of __ksymtab and __ksymtab_gpl ?
I mean that __ksymtab and __ksymtab_gpl are the section headers of ELF 
format.

And how to index to the __ksymtab_strings section header from __ksymtab & 
__ksymtab_gpl ?

Thx



