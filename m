Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbSL0OMJ>; Fri, 27 Dec 2002 09:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbSL0OMJ>; Fri, 27 Dec 2002 09:12:09 -0500
Received: from webmail35.rediffmail.com ([203.199.83.246]:40333 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S264883AbSL0OMI>;
	Fri, 27 Dec 2002 09:12:08 -0500
Date: 27 Dec 2002 14:18:08 -0000
Message-ID: <20021227141808.4478.qmail@webmail35.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Floating Point Exception
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am getting a floating point exception when i run my code.
I am having a IDT 32334 MIPS processor in my board and
i am using cross compiler to build the image.

When the program is executed, it comes out after sometime
with the message "Floating point exception". No other dump is
displayed. Seems to be having some illegal floating point 
operations
in my code.

Can anyone suggest me the reason why i am getting this and
how to solve this?

Thanks in advance,
Nanda



