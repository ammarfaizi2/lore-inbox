Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283272AbRLIKBz>; Sun, 9 Dec 2001 05:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283285AbRLIKBq>; Sun, 9 Dec 2001 05:01:46 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:25097 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP
	id <S283272AbRLIKBb>; Sun, 9 Dec 2001 05:01:31 -0500
Message-ID: <3C133891.4060204@nbase.co.il>
Date: Sun, 09 Dec 2001 12:10:25 +0200
From: eran@nbase.co.il (Eran Man)
User-Agent: Mozilla/6.0 (compatible; MSIE 5.0; Windows 98; DigExt)
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: greearb@candelatech.com, marcelo@conectiva.com.br,
        matthias.andree@stud.uni-dortmund.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17-pre5
In-Reply-To: <Pine.LNX.4.21.0112061705130.21518-100000@freak.distro.conectiva>	<3C0FDFA4.2060701@candelatech.com> <20011206.135845.107259299.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

> 
> 3) VLAN fixes, in particular stop OOPS on module unload.
>    Also fix the build when VLAN is non-modular.
> 

Small correction. The oops is not on module unload, but rather on 
removal of VLAN device.
-- 
Eran Mann                 Direct  : 972-4-9936230
Senior Software Engineer  Fax     : 972-4-9890430
Optical Access            Email   : emann@opticalaccess.com




