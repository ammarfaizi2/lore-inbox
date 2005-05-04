Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVEDKmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVEDKmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 06:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVEDKmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 06:42:33 -0400
Received: from mail.portrix.net ([212.202.157.208]:18156 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261583AbVEDKmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 06:42:31 -0400
Message-ID: <4278A720.4050007@ppp0.net>
Date: Wed, 04 May 2005 12:42:40 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Git-commits mailing list feed.
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>	 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>	 <426A4669.7080500@ppp0.net>	 <1114266083.3419.40.camel@localhost.localdomain>	 <426A5BFC.1020507@ppp0.net>	 <1114266907.3419.43.camel@localhost.localdomain>	 <42788F8C.6090908@ppp0.net> <1115198418.16187.41.camel@hades.cambridge.redhat.com>
In-Reply-To: <1115198418.16187.41.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Wed, 2005-05-04 at 11:02 +0200, Jan Dittmer wrote:
> 
>>Here is an updated version of the script, working with paskys latest
>>tree.
> 
> 
> Thanks. I was planning to get this working today -- looks like you've
> saved me the trouble.

No, I think not. The script breaks for v2.6.12, because tags are sorted
by name not by value.
Needs some sed magic to get the version numbers in a canonical form
first. But I've currently no time to do so, sorry.

Jan

> The chronological output from cg-log is still the wrong thing to do, but
> I suppose it'll have to suffice for now.
