Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271518AbRH0Al3>; Sun, 26 Aug 2001 20:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271582AbRH0AlK>; Sun, 26 Aug 2001 20:41:10 -0400
Received: from [212.159.14.227] ([212.159.14.227]:23991 "HELO
	warrior-outbound.services.quay.plus.net") by vger.kernel.org
	with SMTP id <S271518AbRH0Ak7>; Sun, 26 Aug 2001 20:40:59 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kernel@penguin.linuxhardware.org (Kernel Related Emails),
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support for new chipsets in AGPGART
In-Reply-To: <E15aixW-000838-00@the-village.bc.nu>
From: Adam Sampson <azz@gnu.org>
Organization: The Society Of People Who Repeatedly Point Out That "alot" And "allot" Are Both Wrong, And It Should Be Written "a lot"
Date: 26 Aug 2001 01:35:26 +0100
In-Reply-To: <E15aixW-000838-00@the-village.bc.nu>
Message-ID: <87itfbu08h.fsf@cartman.azz.us-lot.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Attached is a patch to identify two new chipsets in the AGP kernel
> > module.
> Ok I've already got the AMD, I'll check if I dont have the KT266

As a datapoint, I made the same change to 2.4.5 a few weeks ago on a
KT266 machine at work, and it works fine.

-- 
Adam Sampson <azz@gnu.org>                  <URL:http://azz.us-lot.org/>
