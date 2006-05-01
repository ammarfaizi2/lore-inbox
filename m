Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWEAVgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWEAVgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWEAVgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:36:13 -0400
Received: from terminus.zytor.com ([192.83.249.54]:6596 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932273AbWEAVgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:36:12 -0400
Message-ID: <44567F31.9000302@zytor.com>
Date: Mon, 01 May 2006 14:35:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc3-mm1
References: <20060501014737.54ee0dd5.akpm@osdl.org> <625fc13d0605010554l4cadac0fxe7fbc6cd5d57c679@mail.gmail.com> <20060501095913.13a74b2b.akpm@osdl.org> <e35lmt$1iv$1@terminus.zytor.com> <20060501212919.GA21191@mars.ravnborg.org>
In-Reply-To: <20060501212919.GA21191@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, May 01, 2006 at 11:57:33AM -0700, H. Peter Anvin wrote:
>  
>> If it makes your life easier I'd be happy to produce a klibc tree on
>> top of the header cleanup tree.
> klibc is independent today and I really suggest to leave it so until
> header cleanup tree has been merged.
> Otherwise we would end up in a situation where klibc are ready but due
> to dependency on header cleanup we had to wait until 2.6.19.
> 

I should have been more clear.  I have no intention of abandoning the independent klibc 
kernel tree, however, I could easily produce a separate tree with the header cleanup merged.

	-hpa
