Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSFQMAs>; Mon, 17 Jun 2002 08:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSFQMAr>; Mon, 17 Jun 2002 08:00:47 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:50165 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S311025AbSFQMAq>; Mon, 17 Jun 2002 08:00:46 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <UTC200206171107.g5HB74t13348.aeb@smtp.cwi.nl> 
References: <UTC200206171107.g5HB74t13348.aeb@smtp.cwi.nl> 
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jun 2002 13:00:39 +0100
Message-ID: <24035.1024315239@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andries.Brouwer@cwi.nl said:
>  Good. I think it would be worthwhile to find and submit such patches.
> Not just for this attempt of mine, but it is generally a good idea to
> keep things as uniform as possible.

Er, and to prevent us from having to go to the flash, read and possibly 
decompress the link target, every time someone opens a symlink such as 
/lib/ld-linux.so.2 :)

--
dwmw2


