Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSHGBq3>; Tue, 6 Aug 2002 21:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSHGBq3>; Tue, 6 Aug 2002 21:46:29 -0400
Received: from oe-mp2pub.managedmail.com ([206.46.164.23]:33973 "EHLO
	oe-mp2.bizmailsrvcs.net") by vger.kernel.org with ESMTP
	id <S316675AbSHGBq3>; Tue, 6 Aug 2002 21:46:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: niraj gupta <niraj_gupta@imedia-tech.com>
Organization: imedia-tech
To: linux-kernel@vger.kernel.org
Subject: need serial tty driver help - implementing a new uart driver
Date: Tue, 6 Aug 2002 18:50:02 -0700
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020807015002.FBNL7965.oe-mp2.bizmailsrvcs.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i am working on writing a serial - tty driver for a custom board
the uart in implemented in a fpga and has two very simple fifo's for rx/tx
and few bit on status of the fifo, masks for the interrupts. it is a
simple fixed baud rate bit blaster with three wire interface, i was looking
to see if there is an existing driver that i can use/modify, or example
driver to write a new one if need be.

any help is greatly appreciated

TIA
niraj gupta

