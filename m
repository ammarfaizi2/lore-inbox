Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281335AbRKEVDc>; Mon, 5 Nov 2001 16:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281336AbRKEVDW>; Mon, 5 Nov 2001 16:03:22 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:12174 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S281335AbRKEVDP>;
	Mon, 5 Nov 2001 16:03:15 -0500
Message-ID: <3BE6FE99.8020400@stesmi.com>
Date: Mon, 05 Nov 2001 22:03:21 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zack Weinberg <zack@codesourcery.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.20a and gcc 3.0 ?
In-Reply-To: <20011104192024.H267@codesourcery.com> <3BE68F75.3010300@stesmi.com> <20011105120143.M267@codesourcery.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


>>I know how it's done, it's just that in my eyes a stable release is the 
>>one where you know there's only 1 .... A 2.95.4 package built on 
>>different days (from CVS) will differ. A 2.95.4 package built on 
>>different ways from a .tar.gz marked as 'release' will not differ.
>>
>>For instance chasing a kernel bug is difficult when 1 person might use 1 
>>version of a compiler and another uses a different version when both 
>>says 2.95.4, no matter how miniscule the difference.
>>
> 
> Since patches are being applied to the 2.95 branch at a rate of about
> one a month, I think the date stamp in the version number should be
> quite sufficient to avoid any problems along these lines.

If it's tested and rock stable, why isn't it released?

// Stefan


