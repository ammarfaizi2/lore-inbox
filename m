Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314620AbSDTOO7>; Sat, 20 Apr 2002 10:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314623AbSDTOO6>; Sat, 20 Apr 2002 10:14:58 -0400
Received: from [194.234.65.222] ([194.234.65.222]:22199 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S314620AbSDTOO6>; Sat, 20 Apr 2002 10:14:58 -0400
Date: Sat, 20 Apr 2002 16:14:55 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: Urban Widmark <urban@teststation.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: O_LARGEFILE support in smbfs?
In-Reply-To: <Pine.LNX.4.33.0204201436490.1218-100000@cola.teststation.com>
Message-ID: <Pine.LNX.4.44.0204201612100.11230-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Apr 2002, Urban Widmark wrote:

> On Sat, 20 Apr 2002, Roy Sigurd Karlsbakk wrote:
> 
> > hi
> > 
> > I'm having problems accessing large files (>2GB) across a mounted share on 
> > a win2k server. Is this a known problem?
> > 
> > I'm running 2.4.18
> 
> 2.4.18 or 2.4.18 with patches that enable large file support in smbfs?
> 
> Patches are currently available from
> 	http://www.hojdpunkten.ac.se/054/samba/index.html

hm ...
i tried patching 2.4.19-pre7-ac2, and it seems like it's already in there. 
is it?

roy 

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

