Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289377AbSA3QK3>; Wed, 30 Jan 2002 11:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289381AbSA3QJz>; Wed, 30 Jan 2002 11:09:55 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:64528 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289382AbSA3QJK>; Wed, 30 Jan 2002 11:09:10 -0500
Date: Wed, 30 Jan 2002 19:09:05 +0300
From: Oleg Drokin <green@namesys.com>
To: Sebastian =?koi8-r?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020130190905.A820@namesys.com>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de> <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020130163951.13daca94.sebastian.droege@gmx.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 30, 2002 at 04:39:51PM +0100, Sebastian Dröge wrote:

> >   BTW, you are running on a IDE system, right?
> Yes.
Ok, I see.
I can reproduce this problem on IDE only.
Our SCSI boxes run without a single problem.
Hm, may be this is IDE corruption thing, Andre Hendrick spoke about,
or was it fixed already?
I am looking into it anyway.

Bye,
    Oleg
