Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318997AbSHSTgU>; Mon, 19 Aug 2002 15:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319000AbSHSTgU>; Mon, 19 Aug 2002 15:36:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27663 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318997AbSHSTgT>; Mon, 19 Aug 2002 15:36:19 -0400
Message-ID: <3D614993.1060508@zytor.com>
Date: Mon, 19 Aug 2002 12:40:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: klibc and logging
References: <3D58B14A.5080500@zytor.com>	<20020819142734.B17471@flint.arm.linux.org.uk> <3D60F9A6.6020304@zytor.com>	<20020819175429.C17471@flint.arm.linux.org.uk> <3D61239A.7030405@zytor.com>	<20020819182542.D17471@flint.arm.linux.org.uk>  <3D612AF5.4080808@zytor.com> <1029785848.19376.58.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2002-08-19 at 18:29, H. Peter Anvin wrote:
> 
>><THINKING OUT LOUD>
>>
>>I wonder if it'd make sense to have /dev/kmsg0..7 that would tack on the
>>priority automatically.
> 
> That stops you doing partial lines in a syslog message. It breaks if we
> later add more levels. Stupid is good in this case

Oki.

	-hpa

