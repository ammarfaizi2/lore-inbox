Return-Path: <linux-kernel-owner+w=401wt.eu-S932780AbWL1JHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbWL1JHY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWL1JHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:07:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:1885 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763AbWL1JHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:07:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gqFvsOHVX/4Jvc+VVmUBYLSn+4McXWw9CTbw2P6paedA8/jUu0oc8LU+qwAF7TBB07/G66w2FoN7FN/YgHb8N6GDGpKCsB4mSx2/iwfrFfQ2hin6T6ykmx/1w7NvEEyx8L11ANZs1qdLY9Hk9TZ8QWDtuQHpBF7wQ9icjJ2OrAs=
Message-ID: <3d57814d0612280107v11ed3b05g4433566ff7a8960f@mail.gmail.com>
Date: Thu, 28 Dec 2006 19:07:21 +1000
From: "Trent Waddington" <trent.waddington@gmail.com>
To: "Rok Markovic" <kernel@kanardia.eu>
Subject: Re: Binary Drivers
Cc: "James C Georgas" <jgeorgas@rogers.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <45938788.4010201@kanardia.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061226112040.95091.qmail@web32614.mail.mud.yahoo.com>
	 <1167139732.15424.48.camel@Rainsong> <45938788.4010201@kanardia.eu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/06, Rok Markovic <kernel@kanardia.eu> wrote:
> Do we have a right to reverse engineer hardware, or they are protected by
> patents or something similar that would prevent you from publishing results
> adn/or drivers (open source).

This is a pretty good resource:

   http://www.chillingeffects.org/reverse/faq.cgi

Yes, there are probably patents covering this hardware stuff.. and
that's why we have all those open source companies that have given
their patents to an entity that promises to sue in retalitation if
they try to use their patents against open source.  So let's not worry
about patents ok?  They'd be screwed more than us if they try to use
them.

>
> Are there any restrictions in how you obtain information - signal analyser,
> disassembly of windows driver, etc.

Not as far as I am aware.  Obviously if you were to disassemble a
windows driver, add a wrapper and reassemble, that would be copying..
but if you are trying to figure out how something works by reverse
engineering a windows driver then that's ok.  At least it is where I
live (Australia) because we have laws that allow us to ignore license
restrictions that say "thou shalt not reverse engineer" for most
interesting purposes.  Maybe you have similar laws where you live.
Maybe not.

Hope that helps,

Trent
