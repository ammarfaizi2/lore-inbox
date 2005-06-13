Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVFMWzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVFMWzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVFMWwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:52:45 -0400
Received: from mail.timesys.com ([65.117.135.102]:41486 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261602AbVFMWus convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:50:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Attempted summary of "RT patch acceptance" thread
Date: Mon, 13 Jun 2005 18:43:18 -0400
Message-ID: <3D848382FB72E249812901444C6BDB1D0158819A@exchange.timesys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Attempted summary of "RT patch acceptance" thread
thread-index: AcVwaDLrc8Ej1s8WTdG02kKoCPs7wQAASGew
From: "Saksena, Manas" <Manas.Saksena@timesys.com>
To: "Bill Huey \(hui\)" <bhuey@lnxw.com>
Cc: <karim@opersys.com>, <dwalker@mvista.com>, <paulmck@us.ibm.com>,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Lee Revell" <rlrevell@joe-job.com>, "Tim Bird" <tim.bird@am.sony.com>,
       <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@elte.hu>,
       <pmarques@grupopie.com>, <bruce@andrew.cmu.edu>,
       <nickpiggin@yahoo.com.au>, <ak@muc.de>, <sdietrich@mvista.com>,
       <hch@infradead.org>, <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Mon, Jun 13, 2005 at 06:20:10PM -0400, Saksena, Manas wrote:
>> Keep in mind that Linux has been making inroads into traditional RTOS
>> markets for 4+ years. RTOSes have been used in many devices and
>> systems -- many of which do not need the "ruby/diamond" hard variety
>> of real-time -- preempt-rt would be hard-enough for a very large
>> number of devices/systems that currently use an RTOS (or non mainline
>> Linux kernel).
> 
> It's better to use different terminology. The notion of real time is
> *not* a single dimensional vector that is either "more" or "less"
> than of any particular thing. It's much more complicated than that.  

I agree. But, I thought that it is better than soft/hard dichotomy
of real-time, which makes even less sense in reality. Or, worse the
dichotomy of non real-time and real-time -- which is the point I was
trying to make. And, even though, in practice we talk about real-time
operating systems vs non real-time operating systems -- the difference
is not that fundamental as some would like to believe. 

Manas
