Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWH3S0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWH3S0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWH3S0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:26:03 -0400
Received: from ns.suse.de ([195.135.220.2]:43159 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751294AbWH3S0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:26:01 -0400
From: Andi Kleen <ak@suse.de>
To: pageexec@freemail.hu
Subject: Re: [PATCH][RFC] exception processing in early boot
Date: Wed, 30 Aug 2006 20:26:05 +0200
User-Agent: KMail/1.9.3
Cc: Willy Tarreau <w@1wt.eu>, davej@redhat.com, linux-kernel@vger.kernel.org
References: <20060830063932.GB289@1wt.eu> <200608301952.54180.ak@suse.de> <44F5F348.1251.5C4EBCCB@pageexec.freemail.hu>
In-Reply-To: <44F5F348.1251.5C4EBCCB@pageexec.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608302026.05968.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 20:21, pageexec@freemail.hu wrote:
> On 30 Aug 2006 at 19:52, Andi Kleen wrote:
> > On Wednesday 30 August 2006 19:33, pageexec@freemail.hu wrote:
> 
> > > > But I went with the simpler patch with some changes now 
> > > > (added PANIC to the message etc.) 
> > > 
> > > can you post it please?
> > 
> > ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/i386-early-exception
> 
> thanks, although i suggest you put back the hlt as Dick Johnson explained it.

Unless someone can confirm there were not other problems on those 386s/486s
in HLT no.

> 
> > -Andi
> > 
> > P.S.: If you provide patches in the future again also please provide
> > a real name and a Signed-off-by line
> 
> no problem for the signed-off-by, but what passes for a real name?
> i mean, how do i prove it?

We trust you if you tell us.

> ps: sorry but Riley@williams.name bounces for me, removed from cc.

For me too.

-Andi

