Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWBOTNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWBOTNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWBOTNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:13:31 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:5370 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S932115AbWBOTNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:13:31 -0500
Date: Wed, 15 Feb 2006 11:13:11 -0800 (PST)
From: Daniel Walker <dwalker@mvista.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
In-Reply-To: <1140030671.4117.50.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0602151112590.14526@dhcp153.mvista.com>
References: <20060215151711.GA31569@elte.hu>  <Pine.LNX.4.64.0602151059300.14526@dhcp153.mvista.com>
 <1140030671.4117.50.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006, Arjan van de Ven wrote:

>
>>> This patchset provides a new (written from scratch) implementation of
>>> robust futexes, called "lightweight robust futexes". We believe this new
>>> implementation is faster and simpler than the vma-based robust futex
>>> solutions presented before, and we'd like this patchset to be adopted in
>>> the upstream kernel. This is version 1 of the patchset.
>>
>>  	Next point of discussion must be PI .
>
> Yes. lets discus PI. Lets discuss it forever so that we'll never get
> it ;)


You can always turn it off..

Daniel
