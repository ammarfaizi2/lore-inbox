Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbRFUNcQ>; Thu, 21 Jun 2001 09:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264958AbRFUNcL>; Thu, 21 Jun 2001 09:32:11 -0400
Received: from [64.64.109.142] ([64.64.109.142]:44818 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S264956AbRFUNbf>; Thu, 21 Jun 2001 09:31:35 -0400
Message-ID: <3B31F70D.70208DDD@didntduck.org>
Date: Thu, 21 Jun 2001 09:30:53 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: rafael@viewpoint.no
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual address 
 - 2.4.5
In-Reply-To: <auto-000000272718@viventus.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Martinez wrote:
> 
> Hello
> 
> I have got a error in my syslog about a Null pointer in the kernel:
> 
> Kernel 2.4.5
> glibc 2.2.12
> gcc version 2.96 20000731 (Red Hat Linux 7.0)
> 
> Modell: ISP2150
> Motherboard: L440GX+ DP
> CPU: 2 x Intel Pentium III (Coppermine) 850 MHz L2 cache: 256K / Bus: 100 MHz
> RAM: 256 MB
> SCSI controller: Adaptec AIC-7896/7 Ultra2

Please run oops messages through ksymoops before posting them here.  The
message is meaningless without knowing what symbols are mapped to what
address.  See linux/Documentation/oops-tracing.txt.

--

				Brian Gerst
