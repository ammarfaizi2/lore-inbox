Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313179AbSDTUzP>; Sat, 20 Apr 2002 16:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313182AbSDTUzO>; Sat, 20 Apr 2002 16:55:14 -0400
Received: from relay1.pair.com ([209.68.1.20]:7181 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S313179AbSDTUzN>;
	Sat, 20 Apr 2002 16:55:13 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CC1D5F8.ACB239F2@kegel.com>
Date: Sat, 20 Apr 2002 13:56:24 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_RAMFS in 2.4.19-pre7-ac2 ???
In-Reply-To: <3CC1A1EF.AF524412@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> 
> Roy wrote:
> > After upgrading to 2.4.19-pre7-ac2, I can't get CONFIG_RAMFS

The release notes say that ramfs needs a bit of work, 
so if you found ramfs was broken, maybe that's why.

> Linux 2.4.19pre7-ac2
> ...
> o       Removepage hooks as per old -ac                 (Christoph Rohland)
>         | This lets shmfs/ramfs keep accounting straight
>         | ramfs needs someone to drop in the other old -ac bits stil

- Dan
