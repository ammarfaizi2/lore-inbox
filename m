Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287189AbSAGVoc>; Mon, 7 Jan 2002 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287191AbSAGVoW>; Mon, 7 Jan 2002 16:44:22 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:10767 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S287189AbSAGVoP>; Mon, 7 Jan 2002 16:44:15 -0500
Date: Mon, 7 Jan 2002 16:44:15 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: nettings@folkwang-hochschule.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 usbnet usb.c: USB device not accepting new address
Message-ID: <20020107164415.N10145@sventech.com>
In-Reply-To: <mailman.1010437020.13415.linux-kernel2news@redhat.com> <200201072141.g07Lf3102857@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201072141.g07Lf3102857@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, Jan 07, 2002 at 04:41:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002, Pete Zaitcev <zaitcev@redhat.com> wrote:
> >  kernel: usb.c: USB device not accepting new address=6 (error=-110)
> 
> And your /proc/interrupts is ... ?

Almost definately > 0. He was getting hard CRC/Timeout's out of the HC.

JE

