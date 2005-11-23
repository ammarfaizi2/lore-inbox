Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbVKWB2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbVKWB2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbVKWB2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:28:09 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:60581 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030304AbVKWB2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:28:08 -0500
Message-ID: <4383C576.6050800@ens-lyon.org>
Date: Tue, 22 Nov 2005 20:27:18 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Folkert van Heusden <folkert@vanheusden.com>
CC: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: capturing oopses
References: <20051122130754.GL32512@vanheusden.com> <20051122140833.GA29822@outpost.ds9a.nl>
In-Reply-To: <20051122140833.GA29822@outpost.ds9a.nl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

>On Tue, Nov 22, 2005 at 02:07:54PM +0100, Folkert van Heusden wrote:
>  
>
>>My 2.6.14 system occasionally crashes; gives a kernel panic. Of course I
>>would like to report it. Now the system locks up hard so I can't copy
>>the stacktrace. The crash dump patches mentioned in oops-tracing.txt all
>>don't work for 2.6.14 it seems. So: what should I do? Get my digicam and
>>take a picture of the display?
>>    
>>
>
>Try the serial port- you can get a copy of the console on ttyS0.
>
>  
>
netconsole works great too.

Brice

