Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268905AbRHPWOq>; Thu, 16 Aug 2001 18:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268906AbRHPWOg>; Thu, 16 Aug 2001 18:14:36 -0400
Received: from zeke.inet.com ([199.171.211.198]:14536 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S268905AbRHPWOV>;
	Thu, 16 Aug 2001 18:14:21 -0400
Message-ID: <3B7C45BE.3828D2CB@inet.com>
Date: Thu, 16 Aug 2001 17:14:22 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question: ip_rcv(), dst_entry (2.2)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've been studying the 2.2 networking code and, well, I'm beginning to
feel overwhelmed...
I think I (mostly) understand the network driver part of it, but I'm
getting lost in the dst_entry area, I think from both directions...
I didn't find a whole lot on google or linux/Documentation .

Does anyone have pointers to information to guide me through the 2.2
networking code?  (Or even volunteers to give me an idea of what I'm
looking at and how it works?)  I'm particularly interested in
information on the API boundaries in the 2.2.x network code.

TIA,

Eli 
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
