Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289659AbSBXE6T>; Sat, 23 Feb 2002 23:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289727AbSBXE6J>; Sat, 23 Feb 2002 23:58:09 -0500
Received: from gw.wmich.edu ([141.218.1.100]:23541 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S289659AbSBXE6B>;
	Sat, 23 Feb 2002 23:58:01 -0500
Subject: Re: [PATCHSET] Linux 2.4.18-rc4-jam1
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Fran?ois Cami <stilgar2k@wanadoo.fr>, "J.A. Magallon" <jamagallon@able.es>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020224030620.GR20060@matchmail.com>
In-Reply-To: <20020223234217.C2023@werewolf.able.es>
	<3C782531.6050701@wanadoo.fr> <1014514801.492.14.camel@psuedomode>
	<1014516072.491.28.camel@psuedomode>  <20020224030620.GR20060@matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 23 Feb 2002 23:57:51 -0500
Message-Id: <1014526676.587.29.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-02-23 at 22:06, Mike Fedyk wrote:
> On Sat, Feb 23, 2002 at 09:01:06PM -0500, Ed Sweetman wrote:
> > Or it could be my ext3 fs corrupting files again.
> > 
> 
> Oy, do you have one of those write-back (behind) ide hard drives?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Probably, it's a WD 100GB.  hdparm says   WriteCache=enabled
I dont know if the bios is set to writeback off hand, I'd have to
reboot, which I'll probably do soon to add in another hdd and possibly
run memtest86 instead of just memtest

