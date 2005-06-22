Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVFVLMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVFVLMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 07:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVFVLMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 07:12:39 -0400
Received: from [85.8.12.41] ([85.8.12.41]:34232 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262787AbVFVLMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 07:12:38 -0400
Message-ID: <42B94786.2010403@drzeus.cx>
Date: Wed, 22 Jun 2005 13:12:06 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
References: <42B7F740.6000807@drzeus.cx>	 <Pine.LNX.4.61.0506211413570.3728@scrub.home> <42B80AF9.2060708@drzeus.cx>	 <Pine.LNX.4.61.0506211451040.3728@scrub.home> <42B80F40.8000609@drzeus.cx>	 <1119359653.18845.55.camel@tara.firmix.at> <42B92D92.7070304@drzeus.cx> <1119434660.2894.47.camel@tara.firmix.at>
In-Reply-To: <1119434660.2894.47.camel@tara.firmix.at>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:

>On Wed, 2005-06-22 at 11:21 +0200, Pierre Ossman wrote:
>  
>
>>I was referring to which of the three types is correct for str*().
>>    
>>
>
>"char" as one can read in every man-page.
>
>  
>

That doesn't really make it a standard though (de facto perhaps). :)
The odds of all those man pages deviating from the standard is probably
very low. But unless someone has actually read the damn thing we won't
know for sure.

Rgds
Pierre

