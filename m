Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVFMWfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVFMWfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVFMWdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:33:13 -0400
Received: from opersys.com ([64.40.108.71]:25870 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261515AbVFMWcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:32:04 -0400
Message-ID: <42AE0BCB.3080106@opersys.com>
Date: Mon, 13 Jun 2005 18:42:19 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Saksena, Manas" <Manas.Saksena@timesys.com>
CC: dwalker@mvista.com, paulmck@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <3D848382FB72E249812901444C6BDB1D01588198@exchange.timesys.com>
In-Reply-To: <3D848382FB72E249812901444C6BDB1D01588198@exchange.timesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Saksena, Manas wrote:
> The needs that Linux and QNX (or, whatever your favorite RTOS is)
> fulfill are not that separate. 

That point of view may not be shared by others.

> Keep in mind that Linux has been making inroads into traditional
> RTOS markets for 4+ years. RTOSes have been used in many devices
> and systems -- many of which do not need the "ruby/diamond" hard
> variety of real-time -- preempt-rt would be hard-enough for a 
> very large number of devices/systems that currently use an RTOS
> (or non mainline Linux kernel). 

Please, Manas, go teach someone else about how Linux has been doing
in the real-time world for the 10 years.

> And, likewise SMP and large system scalability will often conflict
> with desktop performance. Or, interactive performance goals conflict
> with server throughput goals, and so on.... 

Not at this scale.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
