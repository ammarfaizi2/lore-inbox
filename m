Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWC2Km4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWC2Km4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 05:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWC2Km4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 05:42:56 -0500
Received: from illchn-static-203.199.202.17.vsnl.net.in ([203.199.202.17]:13022
	"EHLO pub.isofttechindia.com") by vger.kernel.org with ESMTP
	id S1750750AbWC2Km4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 05:42:56 -0500
Message-ID: <010801c6531d$8283a3a0$7b01a8c0@shiva>
From: "shiva g" <shiva@isofttech.com>
To: <linux-kernel@vger.kernel.org>
Subject: mark_bh in Linux 2.6.12 kernel
Date: Wed, 29 Mar 2006 16:12:43 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-MailScanner-From: shiva@isofttech.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
    We are porting a usb host controller driver from 2.4.18 kernel to 2.6.12 
kernel. We face some issues with
mark_bh( ) call. Can anyone suggest us how we proceed in porting mark_bh( ) 
in the 2.6.12 kernel.

thanks and regards
shiva g 

