Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315752AbSENOAL>; Tue, 14 May 2002 10:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315751AbSENOAK>; Tue, 14 May 2002 10:00:10 -0400
Received: from firewall.oeone.com ([216.191.248.101]:51848 "EHLO
	masouds1.oeone.com") by vger.kernel.org with ESMTP
	id <S315747AbSENOAJ>; Tue, 14 May 2002 10:00:09 -0400
Date: Tue, 14 May 2002 09:59:14 -0400
From: Masoud Sharbiani <masouds@oeone.com>
To: Alvaro de Luna <aluna@datsi.fi.upm.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DOS functions setvect, getvect
Message-ID: <20020514095913.A26511@oeone.com>
In-Reply-To: <3CE11548.C55BBE7@datsi.fi.upm.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Device driver structure in Linux is totally different from what you have
in DOS. there is a book named  "Linux device drivers", ISBN: ISBN: 0-596-00008-1
check that out. 
good luck
Masoud


On Tue, May 14, 2002 at 03:46:48PM +0200, Alvaro de Luna wrote:
> Hi,
>     I'm trying to transform a DOS driver into a Linux one, but don't
> know
>     what functions use to replace "setvect" and "getvect", does anybody
>     knows?
> 
> Thanks,
>     Alvaro.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Masoud Sharabiani
Software Developer, OEone Corporation
#103 - 290 St-Joseph Blvd.  Hull, Quebec J8Y 3Y3
