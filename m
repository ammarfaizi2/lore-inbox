Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbSKSMXC>; Tue, 19 Nov 2002 07:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSKSMXC>; Tue, 19 Nov 2002 07:23:02 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:19639 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264639AbSKSMXC>; Tue, 19 Nov 2002 07:23:02 -0500
Subject: Re: DAC960, 2.4.19 alpha problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "T. Weyergraf" <kirk@colinet.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <kirk-1021119120625.A0116470@hydra.colinet.de>
References: <kirk-1021119120625.A0116470@hydra.colinet.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Nov 2002 12:58:04 +0000
Message-Id: <1037710684.11541.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 11:06, T. Weyergraf wrote:
> Please note, that i am aware, that the alpha will not boot from that device,
> since it's firmware does not see the controller. It will not be used for
> booting. Upgrading to a newer/different distro ist problematic, since the system
> cannot be taken out of service easily ( I can reboot it for testing purposes ).

Does the firmware need to run to make the card work however ? Thats a
problem on some other raid cards that prevents them running on non x86
platforms



