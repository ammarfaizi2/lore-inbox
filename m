Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWFUNrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWFUNrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWFUNrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:47:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:56740 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932144AbWFUNrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:47:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HJzdMB+5F+jY1L+8cn/qvfDntROgIYgrgbvod38l/uAbepaehdGMYsdsxillbzNJNONlAi2xF22LeOeY4XMkbNFTMqv0bOYcLMWlZDojzRwNYH2wMd/BriX7eBDJ+G3hqT2AGQNJOWmIpKQ2b6uyCwlwhwkc3R+/axsBMfZfi60=
Message-ID: <6bffcb0e0606210647m16da3e59o44ad4a48a0f7abfa@mail.gmail.com>
Date: Wed, 21 Jun 2006 15:47:39 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Herbert Rosmanith" <kernel@wildsau.enemy.org>
Subject: Re: gcc-4.1.1 and kernel-2.4.32
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606211320.k5LDKTZW012519@wildsau.enemy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606211317.k5LDHYLv012510@wildsau.enemy.org>
	 <200606211320.k5LDKTZW012519@wildsau.enemy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/06/06, Herbert Rosmanith <kernel@wildsau.enemy.org> wrote:
> >
> > good day,
> >
> > trying to compile 2.4.32 with gcc-4.1.1 (probably any 4.x gcc?) produces
> > a lot of errors, (i.e., declaration of symbols of different types and so on).
>
> oh, hm .. "a lot" is a bit extreme ... 3 errors so far ;-)

Here are patches that fix compilation on 2.4
http://user.it.uu.se/~mikpe/linux/patches/2.4/

>
> kind regards,
> h.rosmanith
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
