Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSKSHkL>; Tue, 19 Nov 2002 02:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSKSHkL>; Tue, 19 Nov 2002 02:40:11 -0500
Received: from mail.set-software.de ([193.218.212.121]:4076 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP
	id <S261908AbSKSHkK> convert rfc822-to-8bit; Tue, 19 Nov 2002 02:40:10 -0500
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Tue, 19 Nov 2002 08:47:01 GMT
Message-ID: <20021119.8470162@knigge.local.net>
Subject: Re: 2.4.xx: 8139 isn't working
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3DD92808.6050208@pobox.com>
References: <20021118.10200352@knigge.local.net> <3DD92808.6050208@pobox.com>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Booting with "noapic" or changing your BIOS to "MP 1.1" instead of "MP
> 1.4" will likely solve the problem.

Booting with "noapic" solves my problem.... Thanks for all your help!


Bye
  Michael




