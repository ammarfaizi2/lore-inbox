Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTFAAPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 20:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTFAAPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 20:15:16 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.36.229]:5033 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S264533AbTFAAPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 20:15:15 -0400
Subject: Re: Linux 2.4.21-rc6
From: Daniel Goller <dgoller@satx.rr.com>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200305311912.29558.mflt1@micrologica.com.hk>
References: <1054321731.13265.8.camel@schlaefer>
	 <20030530205223.GB25810@matchmail.com> <1054364771.17718.1.camel@schlaefer>
	 <200305311912.29558.mflt1@micrologica.com.hk>
Content-Type: text/plain
Organization: 
Message-Id: <1054427952.7416.2.camel@schlaefer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 31 May 2003 19:39:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-31 at 06:12, Michael Frank wrote:
> On Saturday 31 May 2003 15:06, Daniel Goller wrote:
> > On Fri, 2003-05-30 at 15:52, Mike Fedyk wrote:
> > > On Fri, May 30, 2003 at 02:08:51PM -0500, Daniel Goller 
> wrote:
> > > > i tried 2.4.21-rc6 as i was told it might fix the
> > > > mouse stalling on heavy disk IO problem and i would
> > > > like to report that it DOES fix them for the most
> > > > part, even certain compiles/benchmarks/stress tests
> > > > that could stall my pc for seconds now affect the
> > > > mouse for mere fractions of one second, situations
> > > > that used to cause short stalls are now a thing of
> > > > the past
> > > >
> > > > 2.4.21-rc6 is the best kernel i have tried to date
> > > > and i have tried many on my quest to get a smooth
> > > > mouse
> > >
> > > There are reports that 2.4.18 also "fixed" the problems
> > > with the mouse.  Can you verify?
> >
> 
> Yes, it performs similar to -rc6 but not nearly as good as 
> 2.5.70.
> 
> On 2.5.70 the mouse is really smooth all the time, scrollong 
> of large pages in opera is fairly smooth most the time also 
> with large disk io loads such as the script i posted 
> earlier.
> 
> Regards
> Michael
> 

unfortunately the radeon dri is broken in 2.5.70 so i havent tried that
much, need to see if someone already suggests a fix for this unused int
(it seems unused to me, after a *quick* look through the file) i guess i
will have to subscribe now to lkml


