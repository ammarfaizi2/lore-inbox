Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261675AbTCZNLu>; Wed, 26 Mar 2003 08:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbTCZNLu>; Wed, 26 Mar 2003 08:11:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32951
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261675AbTCZNLt>; Wed, 26 Mar 2003 08:11:49 -0500
Subject: Re: System time warping around real time problem - please help
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Fionn Behrens <fionn@unix-ag.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
In-Reply-To: <3E811A77.3060604@nortelnetworks.com>
References: <1048609931.1601.49.camel@rtfm>
	 <Pine.LNX.4.53.0303251152080.29361@chaos> <1048627013.2348.39.camel@rtfm>
	 <3E80D4CC.4000202@mvista.com>  <1048632934.1355.12.camel@rtfm>
	 <1048637613.29944.17.camel@irongate.swansea.linux.org.uk>
	 <3E811A77.3060604@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048689325.31839.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Mar 2003 14:35:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 03:11, Chris Friesen wrote:
> But its awfully nice for low-impact high-resolution timestamps.
> 
> Maybe someday hardware manufacturers will give us a monotonic GHz+ clock that is 
> synced across all cpus and is cheap to read...

x86-64 has HPET

