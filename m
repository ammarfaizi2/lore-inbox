Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSHJGUs>; Sat, 10 Aug 2002 02:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSHJGUr>; Sat, 10 Aug 2002 02:20:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5384 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316614AbSHJGUr>; Sat, 10 Aug 2002 02:20:47 -0400
Message-ID: <3D54B18C.9060500@zytor.com>
Date: Fri, 09 Aug 2002 23:24:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
References: <aivdi8$r2i$1@cesium.transmeta.com> <200208090934.g799YVZe116824@d12relay01.de.ibm.com> <200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com> <3D541018.4050004@zytor.com> <15700.4689.876752.886309@napali.hpl.hp.com> <3D541478.40808@zytor.com> <20020809222736.GJ32427@mea-ext.zmailer.org> <20020810062251.GD2551@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Sat Aug 10, 2002 at 01:27:36AM +0300, Matti Aarnio wrote:
> 
>>  glibc folks are (to an extreme pain) supporting kernels 2.0
>>  (if not from before) to current bleeding edge, and emulating
>>  all fancy dancing available with new system services by doing
>>  some weird gimmicks..
> 
> The glibc folks care about binary compatibility.  klibc doesn't
> need to care about such things, and therefore need not care about
> such baggage.
> 

Exactly.

	-hpa

