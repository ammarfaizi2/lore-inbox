Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSHIUZw>; Fri, 9 Aug 2002 16:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSHIUZw>; Fri, 9 Aug 2002 16:25:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6408 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315746AbSHIUZv>; Fri, 9 Aug 2002 16:25:51 -0400
Message-ID: <3D54260E.9080100@zytor.com>
Date: Fri, 09 Aug 2002 13:29:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
References: <aivdi8$r2i$1@cesium.transmeta.com>	<200208090934.g799YVZe116824@d12relay01.de.ibm.com>	<200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com>	<3D541018.4050004@zytor.com>	<15700.4689.876752.886309@napali.hpl.hp.com>	<3D541E2C.3010000@zytor.com> <15700.9328.817832.974840@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>>>>>>On Fri, 09 Aug 2002 12:55:24 -0700, "H. Peter Anvin" <hpa@zytor.com> said:
>>>>>
> 
>   HPA> You mean alpha calls umount2() "umount" and umount()
>   HPA> "oldumount"?
> 

Cool; I have added this.  I have uploaded the new version as
klibc-0.1.tar.gz to get the version number thing going...

	-hpa


