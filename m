Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSFCTnk>; Mon, 3 Jun 2002 15:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSFCTnj>; Mon, 3 Jun 2002 15:43:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22533 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315440AbSFCTni>; Mon, 3 Jun 2002 15:43:38 -0400
Message-ID: <3CFBC6DD.9040805@zytor.com>
Date: Mon, 03 Jun 2002 12:43:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: isofs unhide option:  troubles with Wine
In-Reply-To: <Pine.LNX.4.44.0206031339360.3833-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> Hi,
> 
> On 3 Jun 2002, H. Peter Anvin wrote:
> 
>>No, I think that's a bad idea.  Make them listed, but make it possible
>>to query the attribute flags.
> 
> 
> So you suggest letting ls do the hide? Or if not, what do we call them 
> "hidden" for?
> 

I don't think it makes any sense for anything in Unix to hide them at all.

The "hidden" flag, however, matters to programs like Wine.

	-hpa


