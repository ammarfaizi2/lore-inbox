Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272342AbRIEW3k>; Wed, 5 Sep 2001 18:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272343AbRIEW3a>; Wed, 5 Sep 2001 18:29:30 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:28427 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272342AbRIEW3T>; Wed, 5 Sep 2001 18:29:19 -0400
Message-ID: <3B969E43.1CB90E7D@namesys.com>
Date: Thu, 06 Sep 2001 01:50:59 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Mack Stevenson <mackstevenson@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Basic reiserfs question
In-Reply-To: <F97b6KZmcK8r6beUzmR00008a0e@hotmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mack Stevenson wrote:
> 
> I would like to know whether log replays take place whenever the system is
> booted or only after it has been incorrectly shutdown. I occasionaly see
> "Warning, log replay (...)" during the boot-up sequence although the system
> had been correctly shut down, and I would like to know if I should worry.
> 
> Thank you
> 
> Mack Stevenson
> 
> _________________________________________________________________
> Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Are you using redhat?  Do your shutdown scripts unmount the filesystem only if
it is ext2?

Hans
