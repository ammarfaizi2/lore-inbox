Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272717AbRILJdT>; Wed, 12 Sep 2001 05:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272721AbRILJdK>; Wed, 12 Sep 2001 05:33:10 -0400
Received: from samar.sasken.com ([164.164.56.2]:64224 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S272717AbRILJc5>;
	Wed, 12 Sep 2001 05:32:57 -0400
Message-ID: <3B9F2BC8.D647A7A@sasken.com>
Date: Wed, 12 Sep 2001 15:02:56 +0530
From: Manoj Sontakke <manojs@sasken.com>
Organization: Sasken Communication Technologies Limited.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Packet tapping
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Is it possible to tap a packet and send it to a userlevel program
before it is sent to appropriate receive function (say ip_rcv()). The
user level program will give the packet back to the kernel for delivery
to appropriate receive function.
	In short, is it possible to have a protocol stack (between layer 2 and
3) to be implemented in useland.

	Is Tun/Tap driver useful here?

Thanks for all the help
Manoj
