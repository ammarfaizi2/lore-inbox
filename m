Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422823AbWJLIfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbWJLIfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422824AbWJLIfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:35:42 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39053 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1422823AbWJLIfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:35:41 -0400
Message-ID: <005a01c6edd9$7cfb7be0$962e8d52@aldipc>
From: "roland" <devzero@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: The Future of ReiserFS development
Date: Thu, 12 Oct 2006 10:36:11 +0200
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What is the plan? Could i
>> migrate from reiserfs to another journaling filesystem?
>
>Of course: Simply backup, mkfs and restore!

not that simple if you have hundreds of thousands or even millions of small 
files !
reiserfs is quite efficient in storing small files.
don`t know if there is anyfilesystem which is as efficient with this.....


