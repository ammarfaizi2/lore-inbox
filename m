Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbRGPJQ4>; Mon, 16 Jul 2001 05:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266620AbRGPJQq>; Mon, 16 Jul 2001 05:16:46 -0400
Received: from weta.f00f.org ([203.167.249.89]:22660 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266520AbRGPJQc>;
	Mon, 16 Jul 2001 05:16:32 -0400
Date: Mon, 16 Jul 2001 21:16:32 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: __KERNEL__ removal
Message-ID: <20010716211632.K11938@weta.f00f.org>
In-Reply-To: <200107151421.f6FELj7H003177@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107151421.f6FELj7H003177@sleipnir.valparaiso.cl>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 10:21:44AM -0400, Horst von Brand wrote:

    Much easier, plain C, no special tools:
    
       include/linux/...
       include/asm/...
       include/glibc/...
    
    where .../glibc/xyz.h contains the shared parts, and the others feel
    free to include that as needed.

Often lots of little files are a pain to edit compared to one larger
file.



  --cw
