Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbRKYMDj>; Sun, 25 Nov 2001 07:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280834AbRKYMD3>; Sun, 25 Nov 2001 07:03:29 -0500
Received: from [195.66.192.167] ([195.66.192.167]:5902 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280825AbRKYMDN>; Sun, 25 Nov 2001 07:03:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove trailing whitespace
Date: Sun, 25 Nov 2001 14:00:43 -0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3BFE8559.1040403@antefacto.com>
In-Reply-To: <3BFE8559.1040403@antefacto.com>
MIME-Version: 1.0
Message-Id: <01112514004301.00864@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 November 2001 15:20, Padraig Brady wrote:
> This (23MB! (5Mb compressed)) patch removes trailing whitespace from
> all files in the kernel, thereby reducing size from 121,865,495 to
> 121,640,841. I.E. reducing size by 224,654 bytes. I don't know if it's
> of any use, but it should be applied now if it is going to be done
> at all.
>
> http://www.iol.ie/~padraiga/linux-2.5.0-strip-ws.diff.gz

Isn't it easier to write a script 'clean_trailing_ws' (or whatever)
and add it to scripts/ ?
Linus can apply such 'cleaning' scripts at times like 2.4 -> 2.5
--
vda
