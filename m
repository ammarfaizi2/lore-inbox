Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbVLFVdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbVLFVdh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbVLFVdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:33:37 -0500
Received: from mail.dvmed.net ([216.237.124.58]:28057 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932632AbVLFVdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:33:36 -0500
Message-ID: <4396039B.2010405@pobox.com>
Date: Tue, 06 Dec 2005 16:33:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Woodhouse <dwmw2@infradead.org>, Brian Gerst <bgerst@didntduck.org>,
       Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	 <20051205121851.GC2838@holomorphy.com>	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>	 <20051206030828.GA823@opteron.random>  <4394696B.6060008@didntduck.org>	 <1133894575.4136.171.camel@baythorne.infradead.org> <1133897035.23610.32.camel@localhost.localdomain>
In-Reply-To: <1133897035.23610.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alan Cox wrote: > On Maw, 2005-12-06 at 18:42 +0000,
	David Woodhouse wrote: > >>There's some work on reverse-engineering the
	BIOS so that you can >>hackishly poke 'new' modes into its tables, but
	it's still not a very >>good option. > > > Especially as the BIOS
	interface at the low level for the analogue end > and the logic driving
	it is board specific. Intel have been fairly clear > why they use the
	BIOS interface. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2005-12-06 at 18:42 +0000, David Woodhouse wrote:
> 
>>There's some work on reverse-engineering the BIOS so that you can
>>hackishly poke 'new' modes into its tables, but it's still not a very
>>good option.
> 
> 
> Especially as the BIOS interface at the low level for the analogue end
> and the logic driving it is board specific. Intel have been fairly clear
> why they use the BIOS interface.

[utter, complete, abrupt tangent]

Since people are talking about BIOS, that made me remember that I wanted 
to mention something of minor significance:

Marvell GPL'd their storage BIOS that ships with their 50xx and 60xx 
cards.  x86 code, not OF.

FWIW.

Now you may return to your regularly scheduled flamewar...

	Jeff


