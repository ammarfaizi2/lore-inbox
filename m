Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318731AbSHWIwB>; Fri, 23 Aug 2002 04:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSHWIwB>; Fri, 23 Aug 2002 04:52:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10742 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318731AbSHWIwA>; Fri, 23 Aug 2002 04:52:00 -0400
Subject: Re: SMP Netfinity 340 hangs under 2.4.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a05111609b98ba20903b0@[129.98.90.227]>
References: <a05111608b98b96373cce@[129.98.90.227]>
	<1030090864.5932.5.camel@irongate.swansea.linux.org.uk> 
	<a05111609b98ba20903b0@[129.98.90.227]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 23 Aug 2002 09:57:29 +0100
Message-Id: <1030093049.5911.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 09:47, Maurice Volaski wrote:
> I haven't tried plain 2.4.19 yet. Should I have reason to not trust 
> these patches?

In the sense that they are not tested by the majority of 2.4.19 users
its always worth checking that.

> So could this be taken to mean the issue is most likely software 
> (presumably kernel)-related?

It normally points to a kernel locking error

