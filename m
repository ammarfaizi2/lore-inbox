Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVAHOli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVAHOli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 09:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVAHOli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 09:41:38 -0500
Received: from wasp.net.au ([203.190.192.17]:20103 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261177AbVAHOlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 09:41:36 -0500
Message-ID: <41DFF122.4020604@wasp.net.au>
Date: Sat, 08 Jan 2005 18:41:38 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at net/ipv4/tcpoutput.c:922 2.6.10-bk7
References: <41DFEDA8.7030805@wasp.net.au>
In-Reply-To: <41DFEDA8.7030805@wasp.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> Warning
> This oops is hand transcribed
> 
> This machine is set up for a serial console, but of course one is never 
> there when you actually need it. It would be handy to perhaps loop the 
> oops once every 60 seconds or so, then you could always connect up a 
> serial console when you get home and capture it.
> There was no I  connected at oops time, so no magic-sysrq would work.
> Any interest in such a thing? Perhaps I could have a go at knocking 
> something up.
> 

Forgot to mention, it's a vanilla kernel pulled from BK when -bk7 was current on kernel.org. It also 
has Jeff's libata-dev-2.6 tree pulled in. No other patches.

Regards,
Brad
