Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSFJRyj>; Mon, 10 Jun 2002 13:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSFJRyi>; Mon, 10 Jun 2002 13:54:38 -0400
Received: from smtp03.wxs.nl ([195.121.6.37]:31208 "EHLO smtp03.wxs.nl")
	by vger.kernel.org with ESMTP id <S313060AbSFJRyh>;
	Mon, 10 Jun 2002 13:54:37 -0400
Message-ID: <3D04E6FB.6E5A18@wxs.nl>
Date: Mon, 10 Jun 2002 19:50:51 +0200
From: Gert Vervoort <gert.vervoort@wxs.nl>
Reply-To: gert.vervoort@wxs.nl
Organization: Planet Internet
X-Mailer: Mozilla 4.6 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: "ata_task_file: unknown command 50"
In-Reply-To: <3D0382B7.20306@megapathdsl.net> <3D04831D.2060207@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin Dalecki wrote:
> 
> Miles Lane wrote:
> > Gert wrote:
> >  > kernel 2.5.21 hangs with repeating the message "ata_task_file:
> > unknown command 50" forever.
> 
> IDE 86 should fix it.

Yes, this patch fixes it.
