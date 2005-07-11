Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVGKVFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVGKVFF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVGKVDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:03:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:46534 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262654AbVGKVAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:00:23 -0400
Subject: Re: Bug in pcmcia-core
From: Lee Revell <rlrevell@joe-job.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42B8565A.5070809@superbug.demon.co.uk>
References: <42B1FF2A.2080608@superbug.demon.co.uk>
	 <20050617014820.GA15045@animx.eu.org>
	 <42B27D51.4040407@superbug.demon.co.uk>
	 <1119368594.19357.22.camel@mindpipe>
	 <20050621165303.GA14487@isilmar.linta.de>
	 <1119375864.4569.10.camel@mindpipe> <42B8565A.5070809@superbug.demon.co.uk>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 17:00:20 -0400
Message-Id: <1121115620.2632.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 19:03 +0100, James Courtier-Dutton wrote:
> linux-2.6.12-rc6-mm1 fails to even boot on my system. See previous
> email for details.
> 
> I have the same problem with 2 different laptops, and those laptops
> had different pcmcia chips, so that is why I suspect the pcmcia-core.

James,

Did you ever try 2.6.13-rcx?  I see that lots of PCMCIA fixes went in
since you posted this.

Lee  

