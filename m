Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTH0JTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 05:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTH0JTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 05:19:23 -0400
Received: from [62.241.33.80] ([62.241.33.80]:61445 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263212AbTH0JTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 05:19:23 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "Marcelo E. Magallon" <mmagallo@debian.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH,BACKPORT] AGPGART support for Intel 7205/7505 chipsets
Date: Wed, 27 Aug 2003 11:18:47 +0200
User-Agent: KMail/1.5.3
References: <20030826122611.GA26314@informatik.uni-stuttgart.de> <20030827091040.GA5935@informatik.uni-stuttgart.de>
In-Reply-To: <20030827091040.GA5935@informatik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308271118.47879.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 August 2003 11:10, Marcelo E. Magallon wrote:

Hi Marcelo,

>  >  Ok, here's the patch again against what's current in the BK tree.  I
>  >  just checked that it still applies and works with 2.4.22.
>  I am sorry, I just noticed I omitted the diff of the include/linux
>  directory.  The missing bits are attached.  The whole patch is
>  available from:
>            http://people.debian.org/~mmagallo/agp-i7x05.diff

you know that your patch is already in? ;-)

http://linux.bkbits.net:8080/linux-2.4/cset@1.1065.1.37?nav=index.html|ChangeSet@-2d

ciao, Marc

