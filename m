Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264078AbRFETFP>; Tue, 5 Jun 2001 15:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264081AbRFETFF>; Tue, 5 Jun 2001 15:05:05 -0400
Received: from t2.redhat.com ([199.183.24.243]:38646 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S264078AbRFETEx>; Tue, 5 Jun 2001 15:04:53 -0400
Message-ID: <3B1D2D54.EC12DD90@redhat.com>
Date: Tue, 05 Jun 2001 20:04:52 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David Gordon (LMC)" <David.Gordon@ericsson.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: kHTTPd hangs 2.4.5 boot when moduled
In-Reply-To: <3B1D27E2.7080701@lmc.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Gordon (LMC)" wrote:

> I found that when kHTTPd is compiled as a module, kernel 2.4.5 will hang
> at boot. However, when kHTTPd is omitted or compiled into the kernel,
> the boot is okay.

This is very strange. Does your kernel do the same if you compile IPv6
as module and khttpd off ?
