Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVALMKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVALMKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 07:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVALMKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 07:10:53 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:55012 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261169AbVALMKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 07:10:47 -0500
Date: Wed, 12 Jan 2005 13:10:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: krishna <krishna.c@globaledgesoft.com>
cc: lirc <lirc-list-request@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LIRC for Infra Red port.
In-Reply-To: <41E510C7.5060100@globaledgesoft.com>
Message-ID: <Pine.LNX.4.61.0501121310010.14535@yvahk01.tjqt.qr>
References: <41E510C7.5060100@globaledgesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi all,
>
>   I am working on LIRC-serial.
>
> But in my main board I also have Infra Red Port. I don't want to use the serial
> port so that it I can use for some other purpose.
> Does any one know How could I use the IR port instead of Serial port.

The BIOS has a switch to reserve COM2 (maybe others) for IR, hopefully.



Jan Engelhardt
-- 
ENOSPC
