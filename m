Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSEUMat>; Tue, 21 May 2002 08:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSEUMas>; Tue, 21 May 2002 08:30:48 -0400
Received: from xsmtp.ethz.ch ([129.132.97.6]:3110 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S313711AbSEUMar>;
	Tue, 21 May 2002 08:30:47 -0400
Message-ID: <3CEA3D8D.8090901@debian.org>
Date: Tue, 21 May 2002 14:29:01 +0200
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <mcp@linux-systeme.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: menuconfig|xconfig question
In-Reply-To: <fa.ftrutbv.flidp2@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2002 12:30:46.0962 (UTC) FILETIME=[554E6920:01C200C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc-Christian Petersen wrote:

> Hi there,
> 
> is it possible to have a message box popped up with menuconfig|xconfig if i 
> select something in the config? It would be nice, so really important things 
> are forced to the user.


No. Every configuration option is important! (and in a lot of such
configurations you will not boot if you choose the wrong option).
So it is better not to have such popup box. It will only annoy users.

Some configuration write some text between dangerous options,
or create a sub menu with a warning text.

ciao
	cate



