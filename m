Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSKNCa4>; Wed, 13 Nov 2002 21:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSKNCa4>; Wed, 13 Nov 2002 21:30:56 -0500
Received: from mail.rpi.edu ([128.113.22.40]:27866 "EHLO mail.rpi.edu")
	by vger.kernel.org with ESMTP id <S261371AbSKNCaz>;
	Wed, 13 Nov 2002 21:30:55 -0500
Date: Wed, 13 Nov 2002 21:37:34 -0500 (EST)
From: Hua Qin <qinhua@poisson.ecse.rpi.edu>
To: linux-kernel@vger.kernel.org
Subject: linux  dropping the packet when ip address does not match
Message-ID: <Pine.GSO.4.10.10211132130550.17504-100000@poisson.ecse.rpi.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am wondering where this place should dropping the packets when
receiving packets destination ip address is not belong to the NIC ip
address. It should check in ip_input.c or route.c or lower in the NIC
driver?

Thanks!!

Hua




