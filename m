Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268413AbTCCHWS>; Mon, 3 Mar 2003 02:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268422AbTCCHWS>; Mon, 3 Mar 2003 02:22:18 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:9163
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268413AbTCCHWR>; Mon, 3 Mar 2003 02:22:17 -0500
Date: Mon, 3 Mar 2003 02:30:39 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Prasad <prasad_s@students.iiit.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: redirecting printk to the Serial port
In-Reply-To: <Pine.LNX.4.44.0303031255570.27683-100000@students.iiit.net>
Message-ID: <Pine.LNX.4.50.0303030229081.25240-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0303031255570.27683-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Prasad wrote:

> 
> 
> I have seen the Documentation/serial-console.txt and accordingly gave the 
> kernel arguments console=/dev/ttyS0,9600n8, but even after giving that i 
> am not getting anything to the other end. To check if the serial 
> communication was in place... i tried echo "abc" > /dev/ttyS0 and that 
> worked.

console=ttyS0,38400n8 console=tty1

That works on my boxes.

	Zwane
-- 
function.linuxpower.ca
