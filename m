Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVCIBlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVCIBlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVCIBlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:41:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11139 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262284AbVCIBjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:39:52 -0500
Message-ID: <422E53D4.9010205@pobox.com>
Date: Tue, 08 Mar 2005 20:39:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2
References: <20050308033846.0c4f8245.akpm@osdl.org>	<20050309001604.GC3146@stusta.de> <20050308165345.32c14e3b.akpm@osdl.org>
In-Reply-To: <20050308165345.32c14e3b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> 
>>On Tue, Mar 08, 2005 at 03:38:46AM -0800, Andrew Morton wrote:
>>
>>>...
>>>Changes since 2.6.11-mm1:
>>>...
>>>-fix-buggy-ieee80211_crypt_-selects.patch
>>>
>>> Was wrong.
>>>...
>>
>>I'd say my patch was correct.
> 
> 
> Uh, OK.  Make that "was subject of interminable bunfight".
> 
> Feel free to resend and I'll keep spamming Jeff with it.

It's quite simple:  one specifies dependencies in one place, so that one 
does not have specify dependencies in _every_ place.

AFAICS the thread already reaches that point, people [most of them] 
agree with me, and then throw up their hands as to a fix.

	Jeff



