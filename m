Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbTAAQLh>; Wed, 1 Jan 2003 11:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTAAQLh>; Wed, 1 Jan 2003 11:11:37 -0500
Received: from mail.mediaways.net ([193.189.224.113]:15188 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S267261AbTAAQLg>; Wed, 1 Jan 2003 11:11:36 -0500
Subject: Re: ide harddisk freeze WDC WD1800JB vs VIA VT8235
From: Soeren Sonnenburg <kernel@nn7.de>
To: Mark Rutherford <mark@justirc.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3E13107E.3D579F3@justirc.net>
References: <1041435181.983.76.camel@sun>  <3E13107E.3D579F3@justirc.net>
Content-Type: text/plain
Organization: 
Message-Id: <1041437870.961.87.camel@sun>
Mime-Version: 1.0
Date: 01 Jan 2003 17:17:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-01 at 16:59, Mark Rutherford wrote:
> Q: are you using cables with a slave connector, but its not in use?
> I had this problem, with this chipset and it turned out that it didnt like
> having
> a long 80 wire cable with a loose connector
> I got a round cable with just 2 connectors, 1 for the board and 1 for the
> drive....
> never locked again.
> I thought it to be strange as well.
> but with my setup it happened more frequently, say once every 2-3 hours.
> hope this is of any help.

Thanks for your answer.

Indeed these cables have slave connectors (which are unused). I tried a
round cable and 2 different non-round ones... I also went down to udma4
(==udma66)... no use..

I am not sure whether the harddisk should cold-freeze... 

Soeren.

