Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVASPuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVASPuq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVASPuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:50:46 -0500
Received: from news.suse.de ([195.135.220.2]:3251 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261759AbVASPuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:50:40 -0500
Message-ID: <41EE81CF.2010703@suse.de>
Date: Wed, 19 Jan 2005 16:50:39 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: dtor_core@ameritech.net, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Remove input_call_hotplug
References: <41ED2457.1030109@suse.de> <d120d50005011807566ee35b2b@mail.gmail.com> <41EE2F82.3080401@suse.de> <d120d500050119060530b57cd7@mail.gmail.com> <41EE6BA8.6020705@suse.de> <d120d500050119064461d21d80@mail.gmail.com> <41EE7521.1010900@suse.de> <20050119154946.GA8839@ucw.cz>
In-Reply-To: <20050119154946.GA8839@ucw.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Wed, Jan 19, 2005 at 03:56:33PM +0100, Hannes Reinecke wrote:
> 
> 
>>oops. hadn't thought of that. But of course, you are correct.
>>So better be using monotonically increasing numbers.
>>
>>New patch attached.
> 
> 
> This one looks quite OK to me.
> 
Will you put it into your bk-input tree so that it will eventually find 
its way towards akpm/linus ?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
