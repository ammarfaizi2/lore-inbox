Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290719AbSAYQqd>; Fri, 25 Jan 2002 11:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290720AbSAYQqP>; Fri, 25 Jan 2002 11:46:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49419 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290719AbSAYQp7>; Fri, 25 Jan 2002 11:45:59 -0500
Message-ID: <3C518BC3.1080102@zytor.com>
Date: Fri, 25 Jan 2002 08:45:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <200201242141.g0OLfjL06681@home.ashavan.org.> <Pine.LNX.4.44.0201241545120.2839-100000@waste.org> <a2q1d8$vuj$1@cesium.transmeta.com> <20020125160750.A18035@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:

> 
> Not sure if this is a flaw of gcc or of the standard. If gcc's
> stdbool.h is a standard-compliant implementation of "bool", then
> K&Rv2 seems to endorse this behaviour: from A4.2, "Enumerations
> behave like integers".
> 


This would be a flaw in gcc.

K&Rv2 is C89, so it doesn't apply at all.

	-hpa


