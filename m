Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285507AbRLSV3J>; Wed, 19 Dec 2001 16:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbRLSV3A>; Wed, 19 Dec 2001 16:29:00 -0500
Received: from molly.vabo.cz ([160.216.153.99]:4868 "HELO molly.vabo.cz")
	by vger.kernel.org with SMTP id <S285507AbRLSV2s>;
	Wed, 19 Dec 2001 16:28:48 -0500
Date: Wed, 19 Dec 2001 22:28:35 +0100 (CET)
From: Tomas Konir <moje@molly.vabo.cz>
X-X-Sender: <moje@moje.ich.vabo.cz>
To: Jason Czerak <Jason-Czerak@Jasnik.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Suggestions for linux security patches
In-Reply-To: <1008794926.842.6.camel@neworder>
Message-ID: <Pine.LNX.4.33L2.0112192227460.10104-100000@moje.ich.vabo.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Dec 2001, Jason Czerak wrote:

> I'm running linux 2.4.16, and I"m looking to the best possibly kernel
> patch to harden things up a bit. Primarly I wish to have what is in
> openwall's and grsecurity's patches is the buffer oveflow protection,
> but I'm unable to use the openwall patch because it only support 2.2.X
> kernels ATM. I applied the grsecurity patch but for some reason when
> running mozilla as non-root, the GUI for mozilla is all messed up (and I
> enabled sysctl support so nothing was enabled by default except stuff
> that isn't able to use sysctl).
>
> So to advoid applying 20 or so differnet patches, and evaluate each of
> them (taking up what little time I have in a day...), I wish to get the
> lists opinions on the matter.
>
> Local security/control isn't much of an issue and most likly won't be
> for a while. Remote security and protection from server deamons that
> have buffer problems are high priority to get the best protection for.
>
>

Try http://www.grsecurity.net

 MOJE

-- 
Tomas Konir
Brno
ICQ 25849167


