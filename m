Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUJLSHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUJLSHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUJLSHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:07:16 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:24136 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266511AbUJLSHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:07:10 -0400
Message-ID: <7a329d9104101211077e97ee33@mail.gmail.com>
Date: Tue, 12 Oct 2004 18:07:09 +0000
From: Wil Reichert <wil.reichert@gmail.com>
Reply-To: Wil Reichert <wil.reichert@gmail.com>
To: "mobil@wodkahexe.de" <mobil@wodkahexe.de>
Subject: Re: 2.6.9-rc4 Wrong processor speed
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041012200402.765b2231.mobil@wodkahexe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041012200402.765b2231.mobil@wodkahexe.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just the current speed its running at, M's can drop the CPU to 600MHz
to save power.  Were the boots with the machine plugged or unplugged? 
I've noticed they'll start at the slower speed unplugged.  Something
like cpudyn makes boot speed irrelevant anyway.

Wil

On Tue, 12 Oct 2004 20:04:02 +0200, mobil@wodkahexe.de
<mobil@wodkahexe.de> wrote:
> Hi,
> 
> there seems to be some problem with detecting/displaying processor
> speed.
> 
> 2.6.8.1: Detected 1399.199 MHz processor
> 2.6.9-rc3: Detected 599.541 MHz processor
> 2.6.9-rc4: Detected 599.542 MHz processor
> 
> Machine is an Acer Travelmate 291lci laptop. (Pentium M - centrino - speedstep)
> This machine is running at 600Mhz, if it does not need more power.
> But it should display the real clockspeed at bootup, shouldn't it ?
> 
> Regards, Sebastian
> 
> 
>
