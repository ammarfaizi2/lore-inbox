Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290657AbSBOTPz>; Fri, 15 Feb 2002 14:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290662AbSBOTPr>; Fri, 15 Feb 2002 14:15:47 -0500
Received: from zero.tech9.net ([209.61.188.187]:782 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290657AbSBOTP3>;
	Fri, 15 Feb 2002 14:15:29 -0500
Subject: Re: oops with 2.4.18-pre9-mjc2
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Jameson <rj@open-net.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16bmT9-0003m3-00@the-village.bc.nu>
In-Reply-To: <E16bmT9-0003m3-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 15 Feb 2002 14:15:20 -0500
Message-Id: <1013800521.807.1004.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-15 at 12:48, Alan Cox wrote:

> Please take your bug report to Nvidia. You'll find the binary module
> needs recompiling for pre-empt. Have fun with them 8)

According to his config, preempt-kernel wasn't enabled.

We don't tend to see problems with preempt-kernel + evil-closed-nvidia
driver (for whatever odd reason), anyway.

	Robert Love

