Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289074AbSBONGW>; Fri, 15 Feb 2002 08:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289159AbSBONGN>; Fri, 15 Feb 2002 08:06:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34565 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289074AbSBONGE>;
	Fri, 15 Feb 2002 08:06:04 -0500
Message-ID: <3C6D07B9.596AD49E@mandrakesoft.com>
Date: Fri, 15 Feb 2002 08:06:01 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
In-Reply-To: <E16bhwo-0007GZ-00@bronto.zrz.TU-Berlin.DE>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Elsner wrote:
> 
> I'm currently using kernel 2.4.9-21 from RH, after updating my RH 7.2.
> 
> I want to build a custom kernel 2.4.17 but
> the "Broadcom 5700/5701 Gigabit Ethernet Adapter" (which I need)
> isn't in the source. Obviously an addon from RH.
> 
> Why isn't the driver in the main kernel tree ?

Cuz the driver is a piece of crap, and BroadCom isn't interested in
working with the open source community to fix up the issues.

DaveM and I should have something eventually, which will make the
RH-shipped driver irrelevant.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
