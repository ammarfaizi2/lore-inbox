Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289806AbSBZX7A>; Tue, 26 Feb 2002 18:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289762AbSBZX6u>; Tue, 26 Feb 2002 18:58:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54288 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289484AbSBZX6k>; Tue, 26 Feb 2002 18:58:40 -0500
Message-ID: <3C7C2114.7060700@zytor.com>
Date: Tue, 26 Feb 2002 15:58:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>, marcello@kernel.org
Subject: Re: ftp.kernel.org cleanup
In-Reply-To: <20020227003934.C6669@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

> Hi.
> 
> (This is for ftp mantainers, I think hpa is one (or _the_ one) ?)
> 


No, it's not.  That's an issue for how the kernel maintainers (in this
case, Marcello) want to organize things.  Linus used an "old" directory,
Marcello hasn't so far.

Even if it was you should send to ftpadmin@kernel.org.

[Marcello: if you want, I can do this and also add this stuff to the
"bless-as-final" script.]


> Please, could you move anything but 19-pre1 from /pub/linux/kernel/v2.4/testing
> to /pub/linux/kernel/v2.4/testing/old ?
> There are things since 2.4.16.


	-hpa


