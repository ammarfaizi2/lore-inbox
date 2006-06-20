Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWFTH3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWFTH3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWFTH3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:29:35 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:45469 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S965122AbWFTH3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:29:35 -0400
Date: Tue, 20 Jun 2006 09:29:33 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
Message-ID: <20060620072933.GA3030@rhlx01.fht-esslingen.de>
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <20060619221655.GB1648@openzaurus.ucw.cz> <20060619224312.GB17134@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060619224312.GB17134@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[whoa, maybe I shouldn't have used such an inflammatory subject,
the mail volume would suggest that ;-)]

On Mon, Jun 19, 2006 at 06:43:12PM -0400, Dave Jones wrote:
> On Tue, Jun 20, 2006 at 12:16:55AM +0200, Pavel Machek wrote:
> 
>  > > Am I completely missing something here?
>  > 
>  > Yes. You are missing that modern hw already protects itself. See my  blog on planet.kernel.org.
> 
> And you are missing that not everyone is running linux on the latest CPUs.

Darn right. Intel has been having thermal protection for a somewhat longer
time, but Athlon had serious issues with missing or incompletely functioning
thermal sensors on many not too outdated (let's say it was 4 years ago, ok?)
motherboard/CPU combos.

And I don't really want to know about thermal protection status of various
Cyrix, VIA or even Winchip CPUs (you've been a nic^H^Hïve believer of
competition in a healthy marketplace and bought some of those, right?
I know I did... ;).

But since Pavel's blog mentions that thermal protection is an ACPI
specification, there's hope that it may actually work half-decently
after all.

Andreas Mohr
