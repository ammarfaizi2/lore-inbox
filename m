Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSDQGzB>; Wed, 17 Apr 2002 02:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSDQGzA>; Wed, 17 Apr 2002 02:55:00 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:10509 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S314077AbSDQGy6>; Wed, 17 Apr 2002 02:54:58 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 17 Apr 2002 08:54:02 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: traditional bug: only one of two serial ports found on HP Vectra XM
Message-ID: <3CBD382B.20432.3A9A82@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/Sophos-3.56+2.9+2.03.090+01 April 2002+73161@20020417.064902Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

historically I believed Linux very much. When it said my HP Vecra XM 
only has one serial port I was surprised, but believed it. That was 
some years ago. 2.4.18 still says that there is one serial port:

ttyS00 at 0x3f8 (irq=4) as a 16550A

However recently I had to work on the backside of the PC and found 
two(!) serial ports labelled "Serial A" and "Serial B". So shouldn't 
both ports be detected?

Regards,
Ulrich Windl
(the one who is NOT subscribed in this honourable list)

