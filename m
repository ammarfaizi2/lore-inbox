Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVLFTVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVLFTVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbVLFTVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:21:11 -0500
Received: from mail.dvmed.net ([216.237.124.58]:11416 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030197AbVLFTVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:21:10 -0500
Message-ID: <4395E491.6060807@pobox.com>
Date: Tue, 06 Dec 2005 14:20:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: David Woodhouse <dwmw2@infradead.org>, Bernd Petrovitsch <bernd@firmix.at>,
       Tim Bird <tim.bird@am.sony.com>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com> <20051206005341.GN28539@opteron.random> <4394E750.8020205@am.sony.com> <1133861208.10158.34.camel@tara.firmix.at> <1133863003.4136.42.camel@baythorne.infradead.org> <20051206145025.GY28539@opteron.random>
In-Reply-To: <20051206145025.GY28539@opteron.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andrea Arcangeli wrote: > I think Linus is doing the
	right thing here, and he is avoiding what I > described in the previous
	email: that is breaking drivers gratuitously > is what could make linux
	hostile and too costly to support IMHO. We want > to be parnters with
	all hardware companies, but we want them to support > linux properly
	(not with binary only drivers), in a way that we can fix > it, port it
	to other archs, and so that we don't lose support for the > hardware
	while improving internal APIs. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> I think Linus is doing the right thing here, and he is avoiding what I
> described in the previous email: that is breaking drivers gratuitously
> is what could make linux hostile and too costly to support IMHO. We want
> to be parnters with all hardware companies, but we want them to support
> linux properly (not with binary only drivers), in a way that we can fix
> it, port it to other archs, and so that we don't lose support for the
> hardware while improving internal APIs.

Agreed.

	Jeff


