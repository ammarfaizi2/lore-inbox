Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136779AbRASCet>; Thu, 18 Jan 2001 21:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136813AbRASCei>; Thu, 18 Jan 2001 21:34:38 -0500
Received: from Cantor.suse.de ([194.112.123.193]:23315 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136779AbRASCeU>;
	Thu, 18 Jan 2001 21:34:20 -0500
Date: Fri, 19 Jan 2001 03:39:21 +0100 (CET)
From: egger@suse.de
Reply-To: egger@suse.de
Subject: Re: Hang when booting 2.4.0/2.4.1-pre8 on Compaq 1850R with SMART 3200
To: ian@caliban.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010119024835.A3655@caliban.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010119033327.6E9516E01@Nicole.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan, Ian Macdonald wrote:

> I get the same results when booting 2.4.1-pre8. The system works fine
> with the 2.2.x kernel series, but I need some of the functionality in
> the newer 2.4.x series.

 Try tweaking the controller BIOS, I cannot recall what the option was
 called but there is a switch for different operating system which has
 to be flipped in order to work with 2.4.

-- 

Servus,
       Daniel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
