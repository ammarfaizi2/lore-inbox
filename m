Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293175AbSDDEbr>; Wed, 3 Apr 2002 23:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293076AbSDDEbh>; Wed, 3 Apr 2002 23:31:37 -0500
Received: from nttsitm05223.ppp.infoweb.ne.jp ([211.133.17.223]:25606 "HELO
	might.dyn.to") by vger.kernel.org with SMTP id <S292870AbSDDEbZ>;
	Wed, 3 Apr 2002 23:31:25 -0500
X-Authentication: might was authenticated by nttsitm05223.ppp.infoweb.ne.jp
 at  4 Apr 2002 04:31:17 -0000
X-My-Real-Login-Name: might; localhost
MIME-Version: 1.0
X-Mailer: Denshin 8 Go V32.1.3.1; sp2
Date: Thu, 04 Apr 2002 13:31:05 +0900
From: Hiroyuki Toda <might@might.dyn.to>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: Your message of "Thu, 04 Apr 2002 11:36:06 +1000"
 	<17913.1017884166@kao2.melbourne.sgi.com>
Subject: Re: [PATCH] cleanup KERNEL_VERSION definition and linux/version.h
Message-Id: <20020404043129Z292870-616+5356@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith> >Will kbuild 2.5 go in 2.4 tree also?
Keith> 
Keith> No, but version.h is working at the moment in 2.4.  Why change it?

Because version.h and its generating code (in linux/Makefile) are not smart.



Hiroyuki Toda
