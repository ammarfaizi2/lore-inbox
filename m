Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266134AbRF2Rkx>; Fri, 29 Jun 2001 13:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266132AbRF2Rkn>; Fri, 29 Jun 2001 13:40:43 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:58383 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S266131AbRF2Rkb>; Fri, 29 Jun 2001 13:40:31 -0400
Message-Id: <200106291740.f5THeQU59276@aslan.scsiguy.com>
To: myemail@mycompany.com
cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx kernel driver; ATTN Mr. Justin T. Gibbs 
In-Reply-To: Your message of "Tue, 26 Jun 2001 13:22:26 EDT."
             <3B38C4D2.EB2A8944@mycompany.com> 
Date: Fri, 29 Jun 2001 11:40:26 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Trying to use an AIC7890 SCSI controller with kernel 2.4.5 I have
>the problem reported into the attached log files.  Same problems with
>kernel 2.4.3.

If I understand your problem correctly, the system seems to work
correctly, but you get spurious PCI errors.  I have not been able
to replicate the problem here, but I believe I understand what is
happening.  It should be fixed in 6.1.14.  The errors are, I believe,
harmless.

--
Justin
