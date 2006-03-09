Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWCIN6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWCIN6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWCIN6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:58:49 -0500
Received: from mail.mev.co.uk ([62.49.15.74]:63913 "EHLO mail.mev.co.uk")
	by vger.kernel.org with ESMTP id S1751277AbWCIN6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:58:48 -0500
Message-ID: <4410347C.4010205@mev.co.uk>
Date: Thu, 09 Mar 2006 13:58:20 +0000
From: Ian Abbott <abbotti@mev.co.uk>
User-Agent: Mail/News 1.5 (X11/20060208)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VIA C3 (Ezra C5C) Crashes with longhaul Freq scaling
References: <8be2e100603040646k7f40e8eai391eb914040cb8f8@mail.gmail.com> <20060305043800.GA2253@redhat.com>
In-Reply-To: <20060305043800.GA2253@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2006 13:58:56.0634 (UTC) FILETIME=[9B8F4DA0:01C64381]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/06 04:38, Dave Jones wrote:
> On Sat, Mar 04, 2006 at 10:46:11PM +0800, Shinichi Kudo wrote:
>  > Please, somebody fix this frequency scaling issue!
> 
> I'm actually contemplating marking it CONFIG_BROKEN in mainline,
> as there's not a great deal we can do to make it work without
> significant infrastructure to quiesce DMA.

Good idea!  Too many people fall foul of this (well, I did...).

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
