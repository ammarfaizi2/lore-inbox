Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947213AbWLHUgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947213AbWLHUgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 15:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947217AbWLHUgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:36:17 -0500
Received: from gw.goop.org ([64.81.55.164]:36012 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947213AbWLHUgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:36:16 -0500
Message-ID: <4579CCBC.30109@goop.org>
Date: Fri, 08 Dec 2006 12:36:12 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arkadiusz Miskiewicz <arekm@maven.pl>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: What was in the x86 merge for .20
References: <200612080401.25746.ak@suse.de> <200612081904.33205.ak@suse.de> <200612081910.39684.arekm@maven.pl> <200612082107.54987.ak@suse.de>
In-Reply-To: <200612082107.54987.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> binutils-2.17.50.0.8-1.i686
>> gcc-4.2.0-0.20061206r119598.2.i686
>>     
>
> Hmm, that's not even a release -- afaik gcc 4.2 isn't out yet.
>
> Can you please do
>
> make arch/i386/math-emu/fpu_entry.i
> make arch/i386/math-emu/fpu_entry.s
>
> and send me the resulting .i and .s files privately? 
>   

Me too please.

    J
