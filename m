Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273812AbRIRCsA>; Mon, 17 Sep 2001 22:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273814AbRIRCru>; Mon, 17 Sep 2001 22:47:50 -0400
Received: from ptldme-smtp2.maine.rr.com ([204.210.65.67]:57263 "EHLO
	ptldme-smtp2.maine.rr.com") by vger.kernel.org with ESMTP
	id <S273812AbRIRCra>; Mon, 17 Sep 2001 22:47:30 -0400
Message-ID: <3BA6B626.A301220E@maine.rr.com>
Date: Mon, 17 Sep 2001 22:49:10 -0400
From: "David B. Stevens" <dsteven3@maine.rr.com>
Organization: Penguin Preservation Society
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Magnus Naeslund(f)" <mag@fbab.net>
CC: Ed Tomlinson <tomlins@cam.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org> <034b01c13fea$1764be60$020a0a0a@totalmef>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

"Magnus Naeslund(f)" wrote:
> 
> From: "Ed Tomlinson" <tomlins@cam.org>
> > Hi,
> >
> > You are fast.  Was just going report this one...
> > Using debian sid with gcc 2.95.4.  Both before and after
> > appling the patch below I get:
> >
> 
> The patch seems wrong...
> The files include "compile.h", but should include "compiler.h", no?
> 
> Magnus

You are correct Magnus, it should be compiler.h in the three mm modules.

Cheers,
  Dave
