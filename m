Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWDKSOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWDKSOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 14:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWDKSOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 14:14:05 -0400
Received: from [62.205.161.221] ([62.205.161.221]:36800 "EHLO kir.sacred.ru")
	by vger.kernel.org with ESMTP id S1750841AbWDKSOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 14:14:04 -0400
Message-ID: <443BF1A6.5040805@openvz.org>
Date: Tue, 11 Apr 2006 22:12:54 +0400
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Kirill Korotaev <dev@sw.ru>, Bill Davidsen <davidsen@tmr.com>,
       Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain> <200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com> <443B873B.9040908@sw.ru> <20060411162055.GA22367@MAIL.13thfloor.at>
In-Reply-To: <20060411162055.GA22367@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:

>I think that zero downtime is some kind of marketing
>buzzword here, and has nothing to do with the actual
>time the migration takes, which will probably be
>around 20 seconds or so (for larger guests) ...
>  
>
IMO it is called "zero downtime" because from the user's point of view 
there is no downtime, i.e. network connections are preserved, so what 
user sees is a delay in processing, not a downtime.

