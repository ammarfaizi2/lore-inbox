Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161259AbWHJOkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbWHJOkN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWHJOkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:40:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:12243 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161259AbWHJOkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:40:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UXhv9YV9oPI33Vhu6etdJwKjmfj8EAlc81Ux/AafCVfSLsCkzLQJj3+74JC/5fKcEqet5bE+kvWg77nJtHtsrhHuY2zfayfRjJL/myUCxL3hPPJkaxKxCjB93AzIkpDCu/atg8pScQ/b3NkXsK0fzf72CVJx1xe7wEo8XSgnuOg=
Message-ID: <f96157c40608100740v187a34b1w7d77e5aaf929d8b5@mail.gmail.com>
Date: Thu, 10 Aug 2006 14:40:10 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Molle Bestefich" <molle.bestefich@gmail.com>
Subject: Re: ext3 corruption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f0608100600g54cd0797l2d96f59490542901@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <20060810030602.GA29664@mail>
	 <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
	 <44DB2436.6080501@aitel.hist.no>
	 <62b0912f0608100600g54cd0797l2d96f59490542901@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, Molle Bestefich <molle.bestefich@gmail.com> wrote:
> Helge Hafting wrote:
> > Have you considered debian then?  That package system certainly
> > have been able to keep many a system running for years and years.
> > You never reinstall, just upgrade.
>
> Sounds cool, I'll try that.
> Thanks.
>
> > Well, if you expect to keep a computer running for three years
> > without human intervention - good luck to you!  Not only will there be
> > new vulnerabilities and attacks via the internet in that time,
>
> It's NATted, so it's basically unreachable unless you know how to get to it.

and the villain you have to fear will know much better than anybody
else how to reach the box, that is for sure.

[snip]

> Fair enough, but I've got mdmonitor to send me an email when that happens.
>
> > It is certainly possible to run debian and spend 5min per week
> > on running "apt-get dist-upgrade" which installs anything that
> > was upgraded since the last time.
>
> Cool, a cron job should take care of that.

http://packages.debian.org/testing/admin/cron-apt

[snip]
