Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281042AbRLDRxL>; Tue, 4 Dec 2001 12:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRLDRuP>; Tue, 4 Dec 2001 12:50:15 -0500
Received: from dsl-213-023-038-097.arcor-ip.net ([213.23.38.97]:20493 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S283221AbRLDRsb>;
	Tue, 4 Dec 2001 12:48:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Giacomo Catenazzi <cate@dplanet.ch>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Date: Tue, 4 Dec 2001 18:50:31 +0100
X-Mailer: KMail [version 1.3.2]
Cc: esr@thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011204111115.A15160@thyrsus.com> <19642.1007484062@redhat.com> <3C0CFF5F.3090404@dplanet.ch>
In-Reply-To: <3C0CFF5F.3090404@dplanet.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16BJiE-0000RR-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 4, 2001 05:52 pm, Giacomo Catenazzi wrote:
> I don't think esr changed non problematic rules, but one:
> all rules without help become automatically dependent to
> CONFIG_EXPERIMENTAL. I don't like it, but I understand why
> he makes this decision.

I love it.

--
Daniel
