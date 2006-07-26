Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWGZPhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWGZPhh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWGZPhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:37:37 -0400
Received: from bay0-omc1-s18.bay0.hotmail.com ([65.54.246.90]:34825 "EHLO
	bay0-omc1-s18.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1750833AbWGZPhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:37:36 -0400
Message-ID: <BAY103-F4B9B370BE1CA66EEB4B0FB25B0@phx.gbl>
X-Originating-IP: [85.36.106.198]
X-Originating-Email: [pupilla@hotmail.com]
In-Reply-To: <p733bco5r0g.fsf@verdi.suse.de>
From: "Marco Berizzi" <pupilla@hotmail.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp + acpi
Date: Wed, 26 Jul 2006 17:37:29 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 26 Jul 2006 15:37:33.0567 (UTC) FILETIME=[69BEE0F0:01C6B0C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>"Marco Berizzi" <pupilla@hotmail.com> writes:
>
> > Since 2.6.15 smp doesn't work anymore without ACPI
> > May be possible to have a note in "Symmetric multi processing
> > support" help dialog? Or is it possible to enable ACPI when
> > SMP is selected?
>
>It's probably specific to your system, nothing general.

Hi Andi,

Thanks for the reply. I'm compiling linux on a pentinum
4 HT 3GHz. 2.6.14 did detect both processor, but all
kernels > 2.6.15 did not. (at least till 2.6.17.7)


