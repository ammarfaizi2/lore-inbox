Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317662AbSGRJb3>; Thu, 18 Jul 2002 05:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317681AbSGRJb3>; Thu, 18 Jul 2002 05:31:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58382 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317662AbSGRJb1>; Thu, 18 Jul 2002 05:31:27 -0400
Message-ID: <3D368B9E.1070208@zytor.com>
Date: Thu, 18 Jul 2002 02:34:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, Art Haas <ahaas@neosoft.com>
Subject: Re: Remain Calm: Designated initializer patches for 2.5
References: <20020718085813.8DF8C41A3@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3D366103.8010403@zytor.com> you write:
> 
>>As far as I could tell, *ALL* of these changes broke text alignment in 
>>columns.
> 
> 
> True.
> 
> 
>>It would have been a lot better if they had maintained spacing; I
>>find the new code much more cluttered and hard to read.
> 
> 
> I thought about this: I agree it doesn't look as neat, but "hard to
> read" for what purpose?  It's just as easy to find a particular field
> you're looking for and it's just as easy to find the end of the
> declaration: I couldn't come up with a convincing argument for needing
> to skim-read these declarations, so I didn't complain to the author.
> 

Neatness is about making it easy to read code *quickly*.  The pattern 
recognizer in your brain doesn't work as well on a jumbled mess.

	-hpa



