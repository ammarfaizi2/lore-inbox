Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVAZMUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVAZMUg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 07:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVAZMUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 07:20:36 -0500
Received: from alog0179.analogic.com ([208.224.220.194]:34432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262281AbVAZMUO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 07:20:14 -0500
Date: Wed, 26 Jan 2005 07:19:51 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: dsuljic@mmm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: How to submit device ID into hid blacklist.
In-Reply-To: <OF0CB4FB74.DC0C23B0-ON86256F95.0009A35A-85256F95.000944BB@mmm.com>
Message-ID: <Pine.LNX.4.61.0501260717580.16260@chaos.analogic.com>
References: <OF0CB4FB74.DC0C23B0-ON86256F95.0009A35A-85256F95.000944BB@mmm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 dsuljic@mmm.com wrote:

>
>
>
>
> Hi,
> I work for 3M Touch Systems (former MicroTouch) as software engineer and
> our main product is touchscreen as input device.
> Recently, we have released hid compliant devices (they work perfectly under
> Windows OS), but Linux hid driver does not support us correctly. In kernel
> 2.4 hid driver recognizes our devices and tries to interpret events in best
> manner, but since we are absolute pointing device it was a bit tricky with
> hid mouse on same system. I kernel 2.6 hid core driver grubs our devices
> but does not recognize us as hid device. So we decided, for now, to disable
> hid driver of recognizing our hid devices.
> My question is how can we submit changes to kernel tree.

So why don't you make the appropriate changes to the existing
source code so it supports your device?

> Best regards,
>
> Damir Suljic
> 3M Touch Systems
> 3M Optical Systems Division
> 300 Griffin Brook Park Drive
> Methuen, MA 01844
> 978-659-9386
> dsuljic@mmm.com
> www.3Mtouch.com
> www.touchshowcase.com
>


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
