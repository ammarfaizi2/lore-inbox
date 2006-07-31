Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWGaHuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWGaHuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWGaHuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:50:10 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:59684 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964773AbWGaHuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:50:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rswQWcDoUjDx15vxXWutBffr50DkCT49RRtYTCFXOFio7wTI6Cqw9MG/M+chvQolHHsKA+dYooBGjtwLCCe/hfwo5kyFppygNisyhH0vaRiKOoaPHK/VCPGDaNtMl6MZlHRQ2QBwt9/oFYb75NJ/UOVwrX7ADBDKZqIAJUhYxTA=
Message-ID: <72dbd3150607310050v1b3e5a9y23f40777fb00aac4@mail.gmail.com>
Date: Mon, 31 Jul 2006 00:50:07 -0700
From: "David Rees" <drees76@gmail.com>
To: "bert hubert" <bert.hubert@netherlabs.nl>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Tomasz Torcz" <zdzichu@irc.pl>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
In-Reply-To: <20060730195342.GA32665@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060730120844.GA18293@outpost.ds9a.nl>
	 <20060730160738.GB13377@irc.pl>
	 <1154288811.2941.45.camel@laptopd505.fenrus.org>
	 <20060730195342.GA32665@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/06, bert hubert <bert.hubert@netherlabs.nl> wrote:
> On Sun, Jul 30, 2006 at 09:46:51PM +0200, Arjan van de Ven wrote:
>
> > as a side note ... you realize that clockmod doesn't actually save you
> > any power right? ;)
>
> Indeed, and I've measured that too. But it saves an awful amount of noise!

If it doesn't save you power, how does it reduce noise? I guess it
keeps you from overheating your processor which causes the fan to spin
up?

-Dave
