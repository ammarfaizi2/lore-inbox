Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbVLFKJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbVLFKJn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVLFKJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:09:43 -0500
Received: from mail.dvmed.net ([216.237.124.58]:60563 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751394AbVLFKJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:09:42 -0500
Message-ID: <43956355.5030709@pobox.com>
Date: Tue, 06 Dec 2005 05:09:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Bernd Petrovitsch <bernd@firmix.at>, Tim Bird <tim.bird@am.sony.com>,
       Andrea Arcangeli <andrea@suse.de>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	 <200512051826.06703.andrew@walrond.org>	 <1133817575.11280.18.camel@localhost.localdomain>	 <1133817888.9356.78.camel@laptopd505.fenrus.org>	 <1133819684.11280.38.camel@localhost.localdomain>	 <4394D396.1020102@am.sony.com> <20051206005341.GN28539@opteron.random>	 <4394E750.8020205@am.sony.com>  <1133861208.10158.34.camel@tara.firmix.at> <1133863003.4136.42.camel@baythorne.infradead.org>
In-Reply-To: <1133863003.4136.42.camel@baythorne.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  David Woodhouse wrote: > Since the protection of
	EXPORT_SYMBOL_GPL() is only relevant if you are > actually found to be
	in violation of the licence, we might as well be > using it for all
	symbols. If you fervently believe that binary-only > modules are legal,
	you can still go ahead and use them. It's just that > you'd better be
	_very_ sure of yourself before you do so, because if you > _do_ lose in
	court you'll be getting more than a slap on the wrist. > > By switching
	in the opposite direction, Linus is actively weakening our > position,
	and I object very strongly to that. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> Since the protection of EXPORT_SYMBOL_GPL() is only relevant if you are
> actually found to be in violation of the licence, we might as well be
> using it for all symbols. If you fervently believe that binary-only
> modules are legal, you can still go ahead and use them. It's just that
> you'd better be _very_ sure of yourself before you do so, because if you
> _do_ lose in court you'll be getting more than a slap on the wrist.
> 
> By switching in the opposite direction, Linus is actively weakening our
> position, and I object very strongly to that.


Linus made a pragmatic technical decision for the benefit of a bunch of 
Linux users, a decision I support despite the fact that NVIDIA are a 
bunch of sillyheads.

Realistically, no position was weakened, nothing new happened.

In the context of the larger thread, the doomsday scenario is highly 
unlikely because of positive engineering attributes of open source. 
Smart companies want open source drivers not because people snipe at 
them verbally and legally, but because the process produces superior 
engineering in the end.

	Jeff


