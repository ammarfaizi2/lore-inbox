Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTEaK73 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 06:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbTEaK73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 06:59:29 -0400
Received: from imsantv29.netvigator.com ([210.87.253.76]:55266 "EHLO
	imsantv29.netvigator.com") by vger.kernel.org with ESMTP
	id S264275AbTEaK72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 06:59:28 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Daniel Goller <dgoller@satx.rr.com>, Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Linux 2.4.21-rc6
Date: Sat, 31 May 2003 19:12:29 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <1054321731.13265.8.camel@schlaefer> <20030530205223.GB25810@matchmail.com> <1054364771.17718.1.camel@schlaefer>
In-Reply-To: <1054364771.17718.1.camel@schlaefer>
X-OS: GNU/Linux 2.4.21-pre5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305311912.29558.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 May 2003 15:06, Daniel Goller wrote:
> On Fri, 2003-05-30 at 15:52, Mike Fedyk wrote:
> > On Fri, May 30, 2003 at 02:08:51PM -0500, Daniel Goller 
wrote:
> > > i tried 2.4.21-rc6 as i was told it might fix the
> > > mouse stalling on heavy disk IO problem and i would
> > > like to report that it DOES fix them for the most
> > > part, even certain compiles/benchmarks/stress tests
> > > that could stall my pc for seconds now affect the
> > > mouse for mere fractions of one second, situations
> > > that used to cause short stalls are now a thing of
> > > the past
> > >
> > > 2.4.21-rc6 is the best kernel i have tried to date
> > > and i have tried many on my quest to get a smooth
> > > mouse
> >
> > There are reports that 2.4.18 also "fixed" the problems
> > with the mouse.  Can you verify?
>

Yes, it performs similar to -rc6 but not nearly as good as 
2.5.70.

On 2.5.70 the mouse is really smooth all the time, scrollong 
of large pages in opera is fairly smooth most the time also 
with large disk io loads such as the script i posted 
earlier.

Regards
Michael

