Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbSI1Vfw>; Sat, 28 Sep 2002 17:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262338AbSI1Vfw>; Sat, 28 Sep 2002 17:35:52 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:12928 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261502AbSI1Vfw>;
	Sat, 28 Sep 2002 17:35:52 -0400
Date: Sat, 28 Sep 2002 16:40:55 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Bongani <bonganilinux@mweb.co.za>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Panic 2.5.39
In-Reply-To: <1033247487.1742.19.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209281639410.968-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Sep 2002, Bongani wrote:

> I am using ide-scsi (which I think cause the oops), because the first
> time I saww the Oops it was on scsi_decide_disposition. After a couple
> of reboots this scrolls two lines higher though so I'm not 100% sure
> that they all occur in that function. But all the traces includes it.

I'm using ide-scsi (modular) and I can't duplicate this.

