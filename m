Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269504AbRHGW1E>; Tue, 7 Aug 2001 18:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269512AbRHGW0z>; Tue, 7 Aug 2001 18:26:55 -0400
Received: from bender.toppoint.de ([195.244.243.2]:37256 "EHLO
	mail.toppoint.de") by vger.kernel.org with ESMTP id <S269801AbRHGW0k>;
	Tue, 7 Aug 2001 18:26:40 -0400
>Received: (from netzwurm@localhost)
	by gandalf.discordia (8.9.3/8.9.3/Debian 8.9.3-21) id XAA30332
	for linux-kernel@vger.kernel.org; Tue, 7 Aug 2001 23:40:39 +0200
Date: Tue, 7 Aug 2001 23:40:39 +0200
From: David Spreen <david@spreen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: encrypted swap
Message-ID: <20010807234039.C30244@foobar.toppoint.de>
Mime-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 10:23:15PM +0300, Dan Podeanu wrote:
> There, you have the swap encrypted, up and running. Of course, if you need
> more fancy encryption than the default, XOR or DES, get the crypto patch.
> You only need to have a script that does the stuff, that runs when the
> system boots, without shutdown scripts (in case of power/battery failure

Okay, even if I get the password from /dev/urandom this sounds like a 
solution for people who don't use much swapspace. Because I
have to recreate the swapfs everytime I am booting.

so long...

David
-- 
  __          _              | David "netzwurm" Spreen      Kiel, Germany
 / _|___  ___| |__  __ _ _ _ | http://www.netzwurm.cc/      david@spreen.de
|  _/ _ \/ _ \ '_ \/ _` | '_|| gnupg key (on keyservers):   C8B6823A
|_| \___/\___/_.__/\__,_|_|  | CellPhone:                   +49 173 3874061

