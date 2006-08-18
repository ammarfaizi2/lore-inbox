Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWHRUct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWHRUct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWHRUct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:32:49 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:54447 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S932246AbWHRUcs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:32:48 -0400
Message-ID: <44E623EB.1060908@compro.net>
Date: Fri, 18 Aug 2006 16:32:43 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Fulghum <paulkf@microgate.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Serial issue
References: <1155862076.24907.5.camel@mindpipe>	 <1155915851.3426.4.camel@amdx2.microgate.com>	 <1155923734.2924.16.camel@mindpipe>  <44E602C8.3030805@microgate.com>	 <1155925024.2924.22.camel@mindpipe>	 <Pine.LNX.4.61.0608181512520.19876@chaos.analogic.com>	 <1155928885.2924.40.camel@mindpipe>	 <Pine.LNX.4.61.0608181551510.19978@chaos.analogic.com>	 <44E6221D.4040008@compro.net> <1155932916.2924.47.camel@mindpipe>
In-Reply-To: <1155932916.2924.47.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2006-08-18 at 16:25 -0400, Mark Hounschell wrote:
>> Take it from someone who actually still uses dumb terminals every day,
>> any thing over 9600 baud still requires some kind of flow control for
>> reliable consistent operation. Software (Xon/Xoff) and or hardware
>> (RTS/RTS/DTE) flow control.
>>
> 
> Any idea why the serial console does not work at all with flow control
> enabled (regardless of whether the host runs Linux or another OS)?
> 
> Lee
> 
> 

Your cable is probably wrong.  Both ends have to be using the type of flow
control your cable is wired for.

Mark
