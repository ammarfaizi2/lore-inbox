Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSBXMPz>; Sun, 24 Feb 2002 07:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSBXMPp>; Sun, 24 Feb 2002 07:15:45 -0500
Received: from [195.63.194.11] ([195.63.194.11]:22030 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S286339AbSBXMP3>; Sun, 24 Feb 2002 07:15:29 -0500
Message-ID: <3C78D929.9060403@evision-ventures.com>
Date: Sun, 24 Feb 2002 13:14:33 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <Pine.LNX.4.10.10202232035190.5715-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> Here I question the taking of a patch 12 which altered the behavior of the
> subsystem baseclock to setting up PIO timings for the executing command
> block operations.  I then looked over the patch again and saw you had not
> taken it yet.

This is a lie. It doesn't alter the system base clock.


