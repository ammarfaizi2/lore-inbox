Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbUAIXcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbUAIXcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:32:12 -0500
Received: from imap.gmx.net ([213.165.64.20]:32486 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264467AbUAIXcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:32:09 -0500
X-Authenticated: #4512188
Message-ID: <3FFF39F7.1060205@gmx.de>
Date: Sat, 10 Jan 2004 00:32:07 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Burt <aaron@speakeasy.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: ALSA: bad sound with low CPU load
References: <slrnbvudvn.5ic.aaron@aluminum.bavariati.org>
In-Reply-To: <slrnbvudvn.5ic.aaron@aluminum.bavariati.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Burt wrote:
> Basically, sound comes out as a hissing, garbled mess *unless* I load
> down the CPU.  A kernel compile seems to do nicely for this purpose.

Is CPU Disconnect on? Turn if off and maybe it is OK then. (It was like 
this in Windows with Via KT133 Chipset.)

Try using athcool.

Prakash
