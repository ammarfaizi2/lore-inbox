Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287841AbSANRxW>; Mon, 14 Jan 2002 12:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287848AbSANRxN>; Mon, 14 Jan 2002 12:53:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33805 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287841AbSANRxC>; Mon, 14 Jan 2002 12:53:02 -0500
Message-ID: <3C431AF3.8060905@zytor.com>
Date: Mon, 14 Jan 2002 09:52:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- third draft
In-Reply-To: <1010958148.8691.0.camel@voyager> <a1t270$nq0$1@cesium.transmeta.com> <20020114101529.K26688@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> 
> So, just to clarify, if you have multiple cpio archives concatenated,
> they are gzipped separately before concatenation, or gzipped after
> concatenation?
> 


gzipped before concatenation.

	-hpa


