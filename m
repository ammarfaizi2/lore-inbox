Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbRBMRCX>; Tue, 13 Feb 2001 12:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129492AbRBMRCN>; Tue, 13 Feb 2001 12:02:13 -0500
Received: from dell-pe2450-1.cambridge.redhat.com ([172.16.18.1]:17156 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S129841AbRBMRCH>; Tue, 13 Feb 2001 12:02:07 -0500
Cc: Tony Gale <gale@syntax.dera.gov.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x SMP blamed for Xfree 4.0 crashes 
In-Reply-To: Your message of "Tue, 13 Feb 2001 08:20:33 EST."
             <Pine.LNX.3.95.1010213081530.16233A-100000@chaos.analogic.com> 
Date: Tue, 13 Feb 2001 17:01:50 +0000
Message-ID: <21981.982083710@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had problems with XFree86 4.0 and 4.0.1 locking solidly up under Linux 2.4.x
after about 10mins until I upgraded to XFree86 4.0.2. Now it seems rock solid.
XFree86 3.3.x was always okay.

I've got a Dual-PII machine and an NVidia GeForce.

David
