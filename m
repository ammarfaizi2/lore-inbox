Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289098AbSBDQVZ>; Mon, 4 Feb 2002 11:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289072AbSBDQVI>; Mon, 4 Feb 2002 11:21:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53517 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289062AbSBDQU4>; Mon, 4 Feb 2002 11:20:56 -0500
Message-ID: <3C5EB4CD.5060006@zytor.com>
Date: Mon, 04 Feb 2002 08:20:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: john slee <indigoid@higherplane.net>
CC: linux-kernel@vger.kernel.org, dank@kegel.org
Subject: Re: Asynchronous CDROM Events in Userland
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu> <a3l4uc$laf$1@cesium.transmeta.com> <20020204124344.GA4757@higherplane.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee wrote:

> 
> not so long ago dan kegel suggested an interface to signals based on
> file descriptors, and perhaps even an alpha patch implementing such.
> this allowed you to select() on them.
> 


That's still not a good reason to use signals for this particular interface.

	-hpa


