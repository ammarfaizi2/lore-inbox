Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbSJONiO>; Tue, 15 Oct 2002 09:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262933AbSJONiO>; Tue, 15 Oct 2002 09:38:14 -0400
Received: from ligur.expressz.com ([212.24.178.154]:31397 "EHLO expressz.com")
	by vger.kernel.org with ESMTP id <S262937AbSJONiN>;
	Tue, 15 Oct 2002 09:38:13 -0400
Date: Tue, 15 Oct 2002 15:43:56 +0200 (CEST)
From: "BODA Karoly jr." <woockie@expressz.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42-ac1 serial compile error on sparc
In-Reply-To: <20021014.064142.94841093.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1021015153934.9254A-100000@ligur.expressz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, David S. Miller wrote:

>    	The serial.h is missing for the sparc architecture:
> The 8250 driver is not supported on Sparc, please do
> not enable it.

	Thank you very much. Because the only one ide device is a cdrom
I've tried to compile it in a module but didn't compile. Compiled in it
was successful. But it stopped here:
SILO boot:
Uncompressing image...
\

Is there any way to debug where/why it freezed?

-- 
						Woockie
..."what is there in this world that makes living worthwhile?"
Death thought about it. "CATS," he said eventually, "CATS ARE NICE."
			           (Terry Pratchett, Sourcery)

