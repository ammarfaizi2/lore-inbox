Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268696AbRHBEfq>; Thu, 2 Aug 2001 00:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268705AbRHBEf0>; Thu, 2 Aug 2001 00:35:26 -0400
Received: from c266492-a.lakwod1.co.home.com ([24.1.8.253]:40462 "EHLO
	benatar.snurgle.org") by vger.kernel.org with ESMTP
	id <S268696AbRHBEfW>; Thu, 2 Aug 2001 00:35:22 -0400
Date: Thu, 2 Aug 2001 00:34:54 -0400 (EDT)
From: William T Wilson <fluffy@snurgle.org>
To: Johannes Erdfelt <johannes@erdfelt.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP possible with AMD CPUs?
In-Reply-To: <20010801161005.B784@sventech.com>
Message-ID: <Pine.LNX.4.21.0108020032330.944-100000@benatar.snurgle.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Johannes Erdfelt wrote:

> I don't know if this was true to begin with, but I know that SMP AMD
> systems use the APIC SMP scheme Intel defined and uses.

Is this really true?  I seem to remember that there was very little
difference between OPIC and APIC in the first place, but AMD could not use
APIC because of licensing problems.

Since Athlons cannot use the same motherboards as Intel (unlike the K6-2)
and AMD makes the SMP chipsets for Athlon, why would they possibly want to
use APIC when they could more easily and cheaply use OPIC?

