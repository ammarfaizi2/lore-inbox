Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRATSn3>; Sat, 20 Jan 2001 13:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131629AbRATSnT>; Sat, 20 Jan 2001 13:43:19 -0500
Received: from mserv1d.vianw.co.uk ([195.102.240.96]:59844 "EHLO
	mserv1d.vianw.co.uk") by vger.kernel.org with ESMTP
	id <S131461AbRATSnL>; Sat, 20 Jan 2001 13:43:11 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
Date: Sat, 20 Jan 2001 18:45:10 +0000
Organization: [private individual]
Message-ID: <qtmj6ts01faanviv5l6rgi4cnseugs8lg7@4ax.com>
In-Reply-To: <ejgj6tg2l03r18grn4shgtjmsp5cip6qc9@4ax.com> <Pine.LNX.4.10.11101200938180.2302-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.11101200938180.2302-100000@master.linux-ide.org>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2011 09:51:03 -0800 (PST), you wrote:

>On Sat, 20 Jan 2001, Alan Chandler wrote:
>
>> I'm running with an Abit K7 (uses via82c686a in southbridge) with IBM
>> deskstar 8.4gb disks (DHEA-38451) as masters in ide0 and 1. They only
>> do UDMA mode 2. I am not overclocking or anything - all should be
>> running at default speeds with an Athlon 900.  
>> 
>> Just to be clear - I am NOT getting any errors when I switch back to
>> the 2.2.17 kernel (debian standard) - with a 2.4.0 kernel they occur
>> every few minutes when there is significant disk activity. 
>
>But that kernel uses the stock driver that was the original second
>generation correct?
>
>Andre Hedrick
>Linux ATA Development
>

Sorry, I realise now what I said was ambiguous.  To be clear

2.2.17 - absolutely standard as shipped in debian - no errors
2.4.0 - standard (downloaded tar.bz2) - ERRORS
2.4.0 - as standard except for three files in tar.bz2 attachment to
Vojtech Pavlik's mail which were placed in drivers/ide directory -
ERRORS. 
Alan

alan@chandlerfamily.org.uk
http://www.chandler.u-net.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
