Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278721AbRJVTpj>; Mon, 22 Oct 2001 15:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278824AbRJVTpY>; Mon, 22 Oct 2001 15:45:24 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:33977 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S278844AbRJVToT>; Mon, 22 Oct 2001 15:44:19 -0400
Message-ID: <3BD47790.9F792584@nortelnetworks.com>
Date: Mon, 22 Oct 2001 15:46:24 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: jarausch <jarausch@belgacom.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
In-Reply-To: <Pine.LNX.4.33L.0110221734310.22127-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Mon, 22 Oct 2001 jarausch@belgacom.net wrote:
> 
> > yes I know, you don't like modules without full sources available.
> > But Nvidia is the leading vendor of video cards and all 2.4.x
> > kernels up to 2.4.13-pre5 work nice with this module.
> 
> So get NVIDIA to release the source code for their driver,
> this would allow you to recompile the driver and make it
> work again.
> 
> Note that once NVIDIA stops selling this model video card
> you're stuck with the last supported version of Linux anyway
> and won't be able to upgrade.

Actually, NVIDIA has a HAL-type thing going on and their drivers will support all of their cards from the TNT on up to
the GeForce 3.  The only unsupported models are the Riva128 and Riva128ZX.

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
