Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQLXH6c>; Sun, 24 Dec 2000 02:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbQLXH6N>; Sun, 24 Dec 2000 02:58:13 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:20750 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S129597AbQLXH6I>;
	Sun, 24 Dec 2000 02:58:08 -0500
Date: Sun, 24 Dec 2000 09:27:20 +0200
From: Petru Paler <ppetru@ppetru.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparc64 network-related problems
Message-ID: <20001224092720.A896@ppetru.net>
In-Reply-To: <20001210105553.E728@ppetru.net> <200012101038.CAA06747@pizda.ninka.net> <20001210131033.H728@ppetru.net> <200012101057.CAA09215@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200012101057.CAA09215@pizda.ninka.net>; from davem@redhat.com on Sun, Dec 10, 2000 at 02:57:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Follow-up: in the mean time I upgraded to test13-pre3. Things look fine so
far, but I got this in the kernel log:

TCP: peer 203.65.190.178:25/57885 shrinks window 2375104836:0:2375106284. Bad, what else can I say?                                                                                                 

Should I be worried about it or it's ok ?

On Sun, Dec 10, 2000 at 02:57:21AM -0800, David S. Miller wrote:
>    Date: Sun, 10 Dec 2000 13:10:33 +0200
>    From: Petru Paler <ppetru@ppetru.net>
> 
>    So should I apply your patch ?
> 
> Yes, this new OOPS you've sent me is in the same place.

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
