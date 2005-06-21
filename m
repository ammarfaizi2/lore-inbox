Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVFUSDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVFUSDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVFUSDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:03:13 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:60430 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S262222AbVFUSDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:03:08 -0400
Message-ID: <42B8565A.5070809@superbug.demon.co.uk>
Date: Tue, 21 Jun 2005 19:03:06 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050416)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Dominik Brodowski <linux@dominikbrodowski.net>,
       Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: Bug in pcmcia-core
References: <42B1FF2A.2080608@superbug.demon.co.uk>	 <20050617014820.GA15045@animx.eu.org>	 <42B27D51.4040407@superbug.demon.co.uk>	 <1119368594.19357.22.camel@mindpipe>	 <20050621165303.GA14487@isilmar.linta.de> <1119375864.4569.10.camel@mindpipe>
In-Reply-To: <1119375864.4569.10.camel@mindpipe>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-06-21 at 18:53 +0200, Dominik Brodowski wrote:
> 
>>Check the linux-pcmcia list, check -mm and you'll see that the PCMCIA layer
>>is in the process of being updated.
>>
> 
> 
> OK thanks for the info, sounds like we should try -mm.  It's certainly
> possible that the hardware is buggy.
> 
> Lee
> 

I would try -mm if I could, but I can't.

linux-2.6.12-rc6-mm1 fails to even boot on my system. See previous email
for details.

I have the same problem with 2 different laptops, and those laptops had
different pcmcia chips, so that is why I suspect the pcmcia-core.

James
