Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbUBJAw1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbUBJAw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:52:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:523 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265528AbUBJAwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 19:52:23 -0500
Message-ID: <40282B32.9010302@zytor.com>
Date: Mon, 09 Feb 2004 16:52:02 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Karl Tatgenhorst <ketatgenhorst@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
References: <c07c67$vrs$1@terminus.zytor.com> <40282A37.4090502@comcast.net>
In-Reply-To: <40282A37.4090502@comcast.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karl Tatgenhorst wrote:
>
> Hi,
> 
>      Thanks for asking. I had a critical application that depended on
> them until last week and am now happy to say that even they have moved
> on (I protested the small number of available ptys and explained the
> direction that Unix is going with Unix98 style ptys. Now I depend on
> those. I would be very interested in seeing what you do with your pty
> restructuring as I have a large amount of serial devices.
> 
> Karl Tatgenhorst
>

LOL :)

If the changes I'm working on work out you should be able to have
hundreds of thousands of ptys if you have enough memory.

	-hpa

