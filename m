Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030755AbWI0UVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030755AbWI0UVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030756AbWI0UVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:21:16 -0400
Received: from gw.goop.org ([64.81.55.164]:64488 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030755AbWI0UVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:21:14 -0400
Message-ID: <451ADD44.2030500@goop.org>
Date: Wed, 27 Sep 2006 13:21:24 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: revised pda patches
References: <4518D273.2030103@goop.org> <20060927113136.GA80066@muc.de> <451AAE0A.4010704@goop.org> <20060927194619.GB80066@muc.de>
In-Reply-To: <20060927194619.GB80066@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Yes I dropped all i386-pda-* patches earlier.
>   

"i386-pda-asm-offsets" doesn't really have anything to do with the PDA 
stuff; it's just a generic cleanup. It got posted as a prereq, but I 
don't consider it part of the same patch series (locally it doesn't have 
the i386-pda- prefix).

> Also BTW the result didn't boot. Ok will try with that old patch too.
>   

How did it fail?

    J
