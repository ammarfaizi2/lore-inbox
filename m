Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWIWWzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWIWWzh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 18:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWIWWzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 18:55:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:64138 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750841AbWIWWzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:55:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=py1YYcob9OPh1CpepYdExkxCEdP9ddmTjKaQfjRirMBdWIHNADLFaG+ezFadhmK+fIvX0gLiCC0Acn/fhF+ffY+7YEjjwRh0U8gnd6ElK4zQjuZ18bT1Cza2RIFFguufErgLfNT8YnzeLYo9G8xd5eYgArAonnI2zEgCgDjEW1w=
Message-ID: <4515BB59.6060609@gmail.com>
Date: Sun, 24 Sep 2006 00:54:58 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/3 -repost] pmc551 whitespace cleanup
References: <91anewaa2929331212a91221@wsc.cz> <1159051476.24527.939.camel@pmac.infradead.org>
In-Reply-To: <1159051476.24527.939.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Sat, 2006-09-23 at 12:54 -0400, Jiri Slaby wrote:
>> pmc551 whitespace cleanup
>>
>> Spaces were used for indent, there was more than 80 columns per line.
>> Get
>> rid of that stuff.
>>
>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> These are already applied.

Aah, sorry for repost.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
