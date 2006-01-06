Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWAFTDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWAFTDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWAFTDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:03:16 -0500
Received: from mail.dvmed.net ([216.237.124.58]:24748 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932203AbWAFTDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:03:15 -0500
Message-ID: <43BEBEE1.6060500@pobox.com>
Date: Fri, 06 Jan 2006 14:02:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>	 <1136543914.2940.11.camel@laptopd505.fenrus.org>	 <43BEA672.4010309@pobox.com>  <20060106184841.GA13917@mars.ravnborg.org> <1136574052.2940.68.camel@laptopd505.fenrus.org>
In-Reply-To: <1136574052.2940.68.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Arjan van de Ven wrote: >>Also why should we care so
	much for multi directory modules? > > > I suspect Jeff didn't mean it
	like that, but instead assumed that > multi-directory would be harder
	so that starting with single-directory > would be a good start... [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>Also why should we care so much for multi directory modules?
> 
> 
> I suspect Jeff didn't mean it like that, but instead assumed that
> multi-directory would be harder so that starting with single-directory
> would be a good start...

Correct...

	Jeff



