Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130439AbRA3Wgp>; Tue, 30 Jan 2001 17:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130962AbRA3Wgg>; Tue, 30 Jan 2001 17:36:36 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:21515 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130439AbRA3Wg2>;
	Tue, 30 Jan 2001 17:36:28 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Version 2.4.1 cannot be built. 
In-Reply-To: Your message of "Tue, 30 Jan 2001 16:45:16 CDT."
             <Pine.LNX.3.95.1010130164236.3322A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Jan 2001 09:36:22 +1100
Message-ID: <4697.980894182@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001 16:45:16 -0500 (EST), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>The subject says it all. `make dep` is now broken.
>make[4]: Entering directory `/usr/src/linux-2.4.1/drivers/acpi'
>Makefile:29: *** target pattern contains no `%'.  Stop.

Which version of make are you running?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
