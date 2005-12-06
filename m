Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbVLFXss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVLFXss (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVLFXsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:48:47 -0500
Received: from mail.dvmed.net ([216.237.124.58]:47770 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932557AbVLFXsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:48:47 -0500
Message-ID: <4396233B.2050406@pobox.com>
Date: Tue, 06 Dec 2005 18:48:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Brian Gerst <bgerst@didntduck.org>, Arjan van de Ven <arjan@infradead.org>,
       "M." <vo.sinh@gmail.com>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Reverse engineering (was Re: Linux in a binary world... a	doomsday
 scenario)
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	 <20051205121851.GC2838@holomorphy.com>	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>	 <20051206030828.GA823@opteron.random>	 <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>	 <1133869465.4836.11.camel@laptopd505.fenrus.org>	 <4394ECA7.80808@didntduck.org>  <4395E2F4.7000308@pobox.com>	 <1133897867.29084.14.camel@mindpipe>  <4395E962.2060309@pobox.com>	 <1133898911.29084.25.camel@mindpipe>  <43960774.1000202@pobox.com> <1133907691.29084.50.camel@mindpipe>
In-Reply-To: <1133907691.29084.50.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Lee Revell wrote: > Should this high barrier to entry
	for reverse engineered drivers be > documented anywhere? I would have
	expected black box reverse > engineering to be OK for Linux driver
	development. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Should this high barrier to entry for reverse engineered drivers be
> documented anywhere?  I would have expected black box reverse
> engineering to be OK for Linux driver development.

As I said, the potential for problems is very high.  I did not say it 
was unacceptable.  The barrier for entry is higher, though, yes.

The current case in point is several reverse-engineered wireless 
drivers.  I am not inclined to merge a few of the questionable projects, 
but the Broadcom wireless project seems to have been done right, so it 
will likely get merged quickly (once it passes quality/code reviews, etc.)

	Jeff


