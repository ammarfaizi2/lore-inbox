Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262087AbTCHR3k>; Sat, 8 Mar 2003 12:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262092AbTCHR3k>; Sat, 8 Mar 2003 12:29:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63154
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262087AbTCHR3j>; Sat, 8 Mar 2003 12:29:39 -0500
Subject: Re: hm, page 000f0000 reserved twice ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030308181817.31247f93.skraw@ithnet.com>
References: <20030308181817.31247f93.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047149182.26644.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 08 Mar 2003 18:46:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 17:18, Stephan von Krawczynski wrote:
> Hello all,
> 
> Can any kind soul please tell me what "hm, page xxxx reserved twice" means? And
> additionally: is there any magic involved in getting a serial console working?
> There seems no way to make it work on below system. All "echo >/dev/ttyS0 test"
> do work, but no console output whatsoever visible...

The page reserved twice is just a warning, in this case its harmless and really
its code that wants tidying up

