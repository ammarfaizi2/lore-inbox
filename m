Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268194AbUBRVnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268195AbUBRVnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:43:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24585 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S268194AbUBRVnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:43:43 -0500
Message-ID: <4033DC57.9000908@zytor.com>
Date: Wed, 18 Feb 2004 13:42:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
CC: Tomas Szepe <szepe@pinerecords.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <20040218194744.GB1537@louise.pinerecords.com> <4033C48E.8020409@zytor.com> <200402182222.51110.robin.rosenberg.lists@dewire.com>
In-Reply-To: <200402182222.51110.robin.rosenberg.lists@dewire.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Rosenberg wrote:
> On Wednesday 18 February 2004 21.01, H. Peter Anvin wrote:
> 
>>[And e.g. \U00017777 for characters above \uFFFF]
> 
> Isn't that octal :-)
> 

No.

	-hpa

