Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKUSpN>; Tue, 21 Nov 2000 13:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129150AbQKUSpE>; Tue, 21 Nov 2000 13:45:04 -0500
Received: from quattro.sventech.com ([205.252.248.110]:24330 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129091AbQKUSot>; Tue, 21 Nov 2000 13:44:49 -0500
Date: Tue, 21 Nov 2000 13:14:47 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
Message-ID: <20001121131445.I7764@sventech.com>
In-Reply-To: <E13yDpy-0004ir-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <E13yDpy-0004ir-00@the-village.bc.nu>; from Alan Cox on Tue, Nov 21, 2000 at 01:51:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> o	Dont crash on boot with a dual cpu board holding a non intel cpu

Is this the patch to check for the Local APIC?

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
