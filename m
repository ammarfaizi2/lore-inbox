Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132595AbRDICKu>; Sun, 8 Apr 2001 22:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132601AbRDICKk>; Sun, 8 Apr 2001 22:10:40 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5841 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S132595AbRDICK2>;
	Sun, 8 Apr 2001 22:10:28 -0400
Message-ID: <3AD11A13.6E52A515@mandrakesoft.com>
Date: Sun, 08 Apr 2001 22:10:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Jacobberger <f1j@xmission.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c and 2.4.4-pre1 kernel burp
In-Reply-To: <3AD118F4.3050507@xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Jacobberger wrote:
> 
> Jeff,
> 
> I noticed the following on boot with 2.4.4-pre1:
> 
> kernel: eth0: Too much work at interrupt, IntrStatus=0x0001.
> 
> What is this saying to me :)

How often does this occur?  A lot, or just once or twice?

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
