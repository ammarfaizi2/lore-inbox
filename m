Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273237AbRIUKfQ>; Fri, 21 Sep 2001 06:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRIUKfH>; Fri, 21 Sep 2001 06:35:07 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:1410 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S273237AbRIUKe5>; Fri, 21 Sep 2001 06:34:57 -0400
Message-ID: <3BAB889D.5434E042@rcn.com.hk>
Date: Sat, 22 Sep 2001 02:36:13 +0800
From: David Chow <davidchow@rcn.com.hk>
Organization: Resources Computer Network Ltd.
X-Mailer: Mozilla 4.76 [zh_TW] (X11; U; Linux 2.4.4-1DC i686)
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: Padraig Brady <padraig@antefacto.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA Cyrix C3/MIII CPU
In-Reply-To: <3BA98E0F.F4C052BD@rcn.com.hk> <3BA9D8F7.2030709@antefacto.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig Brady ¼g¹D¡G
> 
> Seems like your init is hanging?
> Are you sure you haven't a glibc compiled for 686?
> 
> Padraig.
> 
> David Chow wrote:
> 
> >Dear all,
> >
> >I am testing my board using the Cyrix C3 733 CPU. After installing the
> >newly compiled kernel 2.4.7 , after the message "freeing unsused memory"
> >and hangs... anyone has this before? I am using the new VIA 694T chipset
> >. Or anyone test the Cyrix C3 CPU? Thanks
> >
> >regards,
> >
> >David
> >

Ok.. it seem's you are right because the root file system is mountd
readonly... okay!. thanks.. I will reinstall the glibc and see if that
fixes... okay.

regards,

David Chow
