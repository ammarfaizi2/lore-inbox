Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTE0Nyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 09:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTE0Nyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 09:54:45 -0400
Received: from mail.ithnet.com ([217.64.64.8]:5640 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263590AbTE0Nyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 09:54:38 -0400
Date: Tue, 27 May 2003 16:07:41 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Werner.Beck@Lidl.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Antwort: Re: Oops in Kernel 2.4.21-rc1
Message-Id: <20030527160741.00bb9723.skraw@ithnet.com>
In-Reply-To: <OFC9BF3818.E07B98DB-ONC1256D33.004C27AB-C1256D33.004C6AE8@lidl.de>
References: <OFC9BF3818.E07B98DB-ONC1256D33.004C27AB-C1256D33.004C6AE8@lidl.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003 15:54:40 +0200
Werner.Beck@Lidl.de wrote:

> unfortunately that is not possible at the moment...
> 

>> Exchange the USB/ISDN part with a pci card and re-try with kernel -rc4.
> 
>> Tell us if that works.
> 
>> Regards,
>> Stephan

Well, what exactly do you expect to hear? There are about a million and one
possibilities about your problem. Most of them are hardware-related. Hoping
that you have already made sure that you have no defective RAM, controller,
mainboard or the like (unlikely since you mention two hosts) I would eliminate
additional risk factors like USB (always gives fun) and use the latest kernel.

Regards,
Stephan
