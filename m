Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282489AbRLSSyH>; Wed, 19 Dec 2001 13:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282495AbRLSSxq>; Wed, 19 Dec 2001 13:53:46 -0500
Received: from freeside.toyota.com ([63.87.74.7]:26383 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S282489AbRLSSxj>; Wed, 19 Dec 2001 13:53:39 -0500
Message-ID: <3C20E1F8.9C8D2825@lexus.com>
Date: Wed, 19 Dec 2001 10:52:40 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "M. R. Brown" <mrbrown@0xd6.org>
CC: nbecker@fred.net, Benoit Poulot-Cazajous <poulot@ifrance.com>,
        linux-kernel@vger.kernel.org
Subject: Re: On K7, -march=k6 is good (Was Re: Why no -march=athlon?)
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com> <20011217174020.GA24772@0xd6.org> <lnitb3drx6.fsf_-_@walhalla.agaha> <20011219175616.GD19236@0xd6.org> <x88itb3njfr.fsf@rpppc1.hns.com> <20011219184745.GF19236@0xd6.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"M. R. Brown" wrote:

> * nbecker@fred.net <nbecker@fred.net> on Wed, Dec 19, 2001:
>
> > Is it safe to use gcc-3.0.2 to compile the kernel?
>
> Absolutely not.  There was at least one reported ICE (internal compiler
> error) with drivers/net/8139too.c.  Stick to the 2.95.x series.

BTW 2.96 is fine also -

cu

jjs

