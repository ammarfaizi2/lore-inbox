Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285745AbRLYTZJ>; Tue, 25 Dec 2001 14:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbRLYTZA>; Tue, 25 Dec 2001 14:25:00 -0500
Received: from flrtn-2-m1-236.vnnyca.adelphia.net ([24.55.67.236]:19341 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S285745AbRLYTYl>;
	Tue, 25 Dec 2001 14:24:41 -0500
Message-ID: <3C28D260.65548D33@pobox.com>
Date: Tue, 25 Dec 2001 11:24:16 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Legacy Fishtank <garzik@havoc.gtf.org>
CC: Manfred Spraul <manfred@colorfullife.com>, Colonel <klink@clouddancer.com>,
        linux-kernel@vger.kernel.org
Subject: Re: RTNETLINK
In-Reply-To: <002001c18d5f$98cb62c0$010411ac@local> <20011225141441.A14941@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy Fishtank wrote:

> It's required by newer RedHat and MDK initscripts, perhaps others.
> ip, iproute and similar utilities use it, and so since it's commonly
> required DaveM made it unconditional...  I think the checkin comment was
> something along the lines of "make it unconditional unless Alan
> complains about kernel bloat" :)

Hmm, perhaps RTNETLINK should be enabled
IFF networking is selected? I see to remember
that was the idea being bandied about...

Anyway, Merry Christmas to all -

jjs

