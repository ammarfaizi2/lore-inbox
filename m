Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277267AbRJIXzm>; Tue, 9 Oct 2001 19:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277268AbRJIXzc>; Tue, 9 Oct 2001 19:55:32 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:60130 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S277267AbRJIXzW>; Tue, 9 Oct 2001 19:55:22 -0400
Message-ID: <01A7DAF31F93D511AEE300D0B706ED9208E48E@axcs13.cos.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: calling vmalloc inside interrupt handler
Date: Tue, 9 Oct 2001 17:55:48 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

It is allowed to call vmalloc/kmalloc inside interrupt handler ?

-hiren
