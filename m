Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292343AbSBPKIn>; Sat, 16 Feb 2002 05:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292347AbSBPKIY>; Sat, 16 Feb 2002 05:08:24 -0500
Received: from duba05h05-0.dplanet.ch ([212.35.36.52]:17937 "EHLO
	duba05h05-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S292344AbSBPKIS>; Sat, 16 Feb 2002 05:08:18 -0500
Message-ID: <3C6E2F3C.3090303@dplanet.ch>
Date: Sat, 16 Feb 2002 11:06:52 +0100
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.5) Gecko/20011023
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild [which is not only ...2]
In-Reply-To: <3C6E1F90.40404@dplanet.ch> <22527.1013851097@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

> cate@dplanet.ch said:
> 
>> I have some comment/explications about the thread about kbuild.
>>
> 
> The thread isn't about kbuild. It's about <omitted>. Please do not confuse
> the two or even mention them in the same mail. It only serves to promote the 
> confusion.
> 
> kbuild is far more obviously the right thing to do. The main objection to it
> last time I saw a discussion was that it has a performance problem in
> certain cases -- which I believe Keith is working on. 


You will confise users...

Notation:
kbuild = kernel build utilities, now = 'kbuild-2.4' + 'CML1' + 
Configure.help.

Thus kbuild is not only Makefiles.

Historically (and I think still in MAINTAINERS file), the
kbuild mailing list is for configurations. There was no
real maintainer of Makefiles.


	giacomo


