Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVC3BqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVC3BqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVC3BqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:46:17 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:52893 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261714AbVC3BqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:46:07 -0500
In-Reply-To: <s5h7jjqkazy.wl@alsa2.suse.de>
References: <1111966920.5409.27.camel@gaston> <1112067369.19014.24.camel@mindpipe> <4a7a16914e8d838e501b78b5be801eca@dalecki.de> <1112084311.5353.6.camel@gaston> <e5141b458a44470b90bfb2ecfefd99cf@dalecki.de> <s5h7jjqkazy.wl@alsa2.suse.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0683ecb1e5fb577a703689d1962ad113@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: Mac mini sound woes
Date: Wed, 30 Mar 2005 03:45:44 +0200
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-03-29, at 12:22, Takashi Iwai wrote:
>
> ALSA provides the "driver" feature in user-space because it's more
> flexible, more efficient and safer than doing in kernel.  It's
> transparent from apps perspective.  It really doesn't matter whether
> it's in kernel or user space.

Yes because it's that wonder full linux sound processing sucks in 
compare
to the other OSs out there doing it in kernel.

> I think your misunderstanding is that you beliieve user-space can't do
> RT.  It's wrong.  See JACK (jackit.sf.net), for example.

I know JACK in and out. It doesn't provide what you claim.

