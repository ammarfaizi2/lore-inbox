Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWAJN1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWAJN1f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWAJN1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:27:35 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43416 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932138AbWAJN1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:27:34 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Tue, 10 Jan 2006 15:26:24 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Yaroslav Rastrigin <yarick@it-territory.ru>,
       andersen@codepoet.org, linux-kernel@vger.kernel.org
References: <174467f50601082354y7ca871c7k@mail.gmail.com> <200601100933.48022.vda@ilport.com.ua> <200601100333.57301.dhazelton@enter.net>
In-Reply-To: <200601100333.57301.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101526.24786.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 10:33, D. Hazelton wrote:
> On Tuesday 10 January 2006 02:33, Denis Vlasenko wrote:
> <snip>
> > Andrew, I think this is a rare (on lkml at least) case when guy
> > does not want to participate in development in a Linux way
> > but wants to just pay for development instead:
> > "I want this <hardware> to work good under Linux. I want to pay
> > up to <sum> to whoever will agree to do that. Anybody?"
> >
> > Do not dismiss him lightly. There are LOTS of people which aren't
> > hackish at all. An order of magniture more than 'us' computer geeks.
> > M$ is successful because it uses this resource.
> > We may want to think how can we use it too.
> >
> > No, I don't think you, or someone else on this list can efficiently
> > use it, but distros, being more commercially oriented, maybe can.
> 
> This is true. The types of bounties I have seen in OS development do not 
> usually reach much beyond $500. If distro's were to get behind this and start 
> offering bounties of large sums for _working_ code for hardware there might 
> be a response.

I meant a different thing. Distro is a commercial entity.
Users can buy services from businesses. "Write (or fix) me a driver"
is a service.

People inclined to just pay for code instead of helping with coding
may have greater success talking to distros.

Of course, distros then will hire someone from lkml crowd to actually do it.

If there will be enough of cash flow from such requests, this can
becode somebody's full time job.
--
vda
