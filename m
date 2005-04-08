Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262917AbVDHSQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbVDHSQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVDHSQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:16:25 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:4124 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262918AbVDHSOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:14:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gEsi0sReQI6bTFgz33m/WxKealr3CtyuSFBGilyNWNVojLdsqL1e7gYshwsZNEnxEj7AhEm5Cyp9ELJB1sIrlCoE/dDuV/dI/C2gjsx4zsCXrGMm7aQq5Y+NI51gLbfGjQQ1cb7FWE4NrgyN+MrsU3/s4xF0sRVuD3ihS9Uw+/s=
Message-ID: <54b5dbf5050408111429b94993@mail.gmail.com>
Date: Fri, 8 Apr 2005 23:44:07 +0530
From: AsterixTheGaul <asterixthegaul@gmail.com>
Reply-To: AsterixTheGaul <asterixthegaul@gmail.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: Linux 2.6.12-rc2
Cc: Moritz Muehlenhoff <jmm@inutil.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <29495f1d05040808393aab2f74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
	 <E1DJE6t-0001T5-UD@localhost.localdomain>
	 <1112827342.9567.189.camel@gaston>
	 <20050407175026.GA5872@informatik.uni-bremen.de>
	 <29495f1d05040711544695ce89@mail.gmail.com>
	 <54b5dbf5050407232810f7a20d@mail.gmail.com>
	 <29495f1d05040808393aab2f74@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its a T41 "without p" :) 

On Apr 8, 2005 9:09 PM, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> On Apr 7, 2005 11:28 PM, AsterixTheGaul <asterixthegaul@gmail.com> wrote:
> > > FWIW, I have the same problem on a T41p with 2.6.11 and 2.6.12-rc2,
> > > except that neither returns from suspend-to-ram with video restored on
> > > the LCD. I believe I was able to get video restored on an external CRT
> > > in either 2.6.12-rc2 or 2.6.12-rc2-mm1, but the LCD still didn't
> > > restore (can verify later today, if you'd like). I had dumped out the
> > > radeontool regs values before & after the sleep, in case they help.
> > > They are attached.
> >
> > Hmm... I have 2.6.12-rc2 on a T41 and "suspend to ram" works good (well
> > except for a backtrace complaining about __might_sleep but otherwise ok).
> 
> A T41 or a T41p? I believe they have different graphics cards...
> 
> Thanks,
> Nish
>
