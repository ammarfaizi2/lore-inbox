Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285517AbRLSVoc>; Wed, 19 Dec 2001 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285532AbRLSVoW>; Wed, 19 Dec 2001 16:44:22 -0500
Received: from [207.148.204.33] ([207.148.204.33]:47628 "HELO
	erasure.jasnik.net") by vger.kernel.org with SMTP
	id <S285517AbRLSVoI>; Wed, 19 Dec 2001 16:44:08 -0500
Subject: Re: Suggestions for linux security patches
From: Jason Czerak <Jason-Czerak@Jasnik.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1008794926.842.6.camel@neworder>
In-Reply-To: <1008794926.842.6.camel@neworder>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Dec 2001 16:44:03 -0500
Message-Id: <1008798243.6214.2.camel@neworder>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-19 at 15:48, Jason Czerak wrote:
> I'm running linux 2.4.16, and I"m looking to the best possibly kernel
> patch to harden things up a bit. Primarly I wish to have what is in
> openwall's and grsecurity's patches is the buffer oveflow protection,
> but I'm unable to use the openwall patch because it only support 2.2.X
> kernels ATM. I applied the grsecurity patch but for some reason when
> running mozilla as non-root, the GUI for mozilla is all messed up (and
I
> enabled sysctl support so nothing was enabled by default except stuff
> that isn't able to use sysctl).
> 
> So to advoid applying 20 or so differnet patches, and evaluate each of
> them (taking up what little time I have in a day...), I wish to get
the
> lists opinions on the matter.
> 

Ok, so 20 or so was a little off base. :) it's more like 3 packages that
are for my type of system and that appear to be activtly developed

1: SeLinux
2. Grsecurity
3. Lids

Lids, and grsecurity appear to be highly configureable and grsecurity
isn't playing nice with some applictions on my system. I'll be testing
out SeLinux and Lids tomarrow, but as one list memeber emailed me
ealier, LIDS has over 500 differnent options, That right there maybe a
turn off for sake of sanity right now. :)



--
Jason Czerak


