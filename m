Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267685AbRGUPvA>; Sat, 21 Jul 2001 11:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbRGUPuu>; Sat, 21 Jul 2001 11:50:50 -0400
Received: from www.transvirtual.com ([206.14.214.140]:5132 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S267685AbRGUPun>; Sat, 21 Jul 2001 11:50:43 -0400
Date: Sat, 21 Jul 2001 08:50:19 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.6] USB thinks I've got 2 keyboards
In-Reply-To: <Pine.LNX.4.33.0107211739340.28026-100000@jdi.jdimedia.nl>
Message-ID: <Pine.LNX.4.10.10107210848220.29725-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


I have seen this. Look for a USB port on your keyboard. Some keyboards
come with a port to plug a USB mouse into. The USB detects this other port
and the HID layer reports it as a USB mouse. It is very normal.

