Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUFJH20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUFJH20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 03:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUFJH20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 03:28:26 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:53768 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262103AbUFJH2Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 03:28:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Soeren Sonnenburg <kernel@nn7.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops on checking for changes of usb input devices
Date: Thu, 10 Jun 2004 10:27:38 +0300
X-Mailer: KMail [version 1.4]
Cc: linuxppc-dev@lists.linuxppc.org
References: <1086847579.24322.34.camel@localhost>
In-Reply-To: <1086847579.24322.34.camel@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406101027.38115.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 June 2004 09:06, Soeren Sonnenburg wrote:
> Hi!
>
> When I attach a ps2 mouse and keyboard through a ps2->usb adapter and
> then do a rescan for changes in input devices I keep getting this oops.
> This is kernel 2.6.7-rc2 on powerbook G4. A way to trigger this is to
> reload/restart pbbuttonsd.
>
> Any ideas ?

I can try to reproduce it, I have 2xPS2->USB adapter.
Tell me more about "do a rescan". I don't do any rescans
(and even don't knw what is a rescan).

I am on x86.
--
vda
