Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263914AbTKJPW5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 10:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263920AbTKJPW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 10:22:57 -0500
Received: from 195-23-16-24.nr.ip.pt ([195.23.16.24]:35974 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S263914AbTKJPW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 10:22:56 -0500
Message-ID: <3FAFAD59.1040507@grupopie.com>
Date: Mon, 10 Nov 2003 15:23:05 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tomasz Chmielewski <mangoo@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compressed tmpfs
References: <3FAF894C.4040806@interia.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tomasz Chmielewski wrote:

> Hello,
> 
> I was looking for something like tmpfs, but with additional feature - 

> that all the files in that file system would be compressed.


I'm working on something like a "compressed read/write loopback device", that 
might do what you want.

I hope to have something to show by the end of this week, so if you wait a 
little maybe i'll be able to solve your problem :)

-- 
Paulo Marques
Software Development Department
www.grupopie.com

