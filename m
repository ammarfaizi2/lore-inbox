Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbVLFTya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVLFTya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbVLFTya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:54:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:43745 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030202AbVLFTy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:54:29 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brian Gerst <bgerst@didntduck.org>, Arjan van de Ven <arjan@infradead.org>,
       "M." <vo.sinh@gmail.com>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4395E962.2060309@pobox.com>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>
	 <20051206030828.GA823@opteron.random>
	 <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>
	 <1133869465.4836.11.camel@laptopd505.fenrus.org>
	 <4394ECA7.80808@didntduck.org>  <4395E2F4.7000308@pobox.com>
	 <1133897867.29084.14.camel@mindpipe>  <4395E962.2060309@pobox.com>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 14:55:11 -0500
Message-Id: <1133898911.29084.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 14:41 -0500, Jeff Garzik wrote:
> Lee Revell wrote:
> > On Tue, 2005-12-06 at 14:13 -0500, Jeff Garzik wrote:
> >>Let's hope the rev-eng people do it the right way, by having one team 
> >>write a document, and a totally separate team write the driver from
> >>that document.
> 
> > Isn't it also legal for a single person or team to capture all IO
> > to/from the device with a bus analyzer or kernel debugger and write a
> > driver from that, as long as you don't disassemble the original driver?
> 
> It's still legally shaky.  The "Chinese wall" approach I described above 
> is beyond reproach, and that's where Linux needs to be.

I know you are not a lawyer but do you have a pointer or two?  As long
as we are REing for interoperability I've never read anything to
indicate the approach I described could be a problem even in the US.

Lee

