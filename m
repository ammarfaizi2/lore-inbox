Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbSJLPZw>; Sat, 12 Oct 2002 11:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSJLPZw>; Sat, 12 Oct 2002 11:25:52 -0400
Received: from beta.bandnet.com.br ([200.195.133.131]:35086 "EHLO
	beta.bandnet.com.br") by vger.kernel.org with ESMTP
	id <S261273AbSJLPZv>; Sat, 12 Oct 2002 11:25:51 -0400
Message-ID: <004e01c27204$075d8400$cddea7c8@bsb.virtua.com.br>
From: "Breno" <breno_silva@bandnet.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Problem with VM flags
Date: Sat, 12 Oct 2002 12:28:34 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have a problem with my VM source:
http://www.bandnet.com.br/~breno_silva/vm.txt , when nopage is called the
source doesnt return "return page;" , this only print until
"printk("<2>Final Nopage\n");

I think the problem is VM flags , somebody can help me ?

thanks
Breno

