Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273810AbRIRCnV>; Mon, 17 Sep 2001 22:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273812AbRIRCnK>; Mon, 17 Sep 2001 22:43:10 -0400
Received: from tomts15-srv.bellnexxia.net ([209.226.175.3]:55695 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S273810AbRIRCnE>; Mon, 17 Sep 2001 22:43:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: "Magnus Naeslund(f)" <mag@fbab.net>
Subject: Re: Linux 2.4.10-pre11
Date: Mon, 17 Sep 2001 23:38:29 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org> <034b01c13fea$1764be60$020a0a0a@totalmef>
In-Reply-To: <034b01c13fea$1764be60$020a0a0a@totalmef>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010918033830.76A2A62ACB@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 17, 2001 10:31 pm, Magnus Naeslund(f) wrote:
> From: "Ed Tomlinson" <tomlins@cam.org>
>
> > Hi,
> >
> > You are fast.  Was just going report this one...
> > Using debian sid with gcc 2.95.4.  Both before and after
> > appling the patch below I get:
>
> The patch seems wrong...
> The files include "compile.h", but should include "compiler.h", no?

I should have caught that...  It works changeing compile.h to compiler.h

Thanks
Ed Tomlinson
