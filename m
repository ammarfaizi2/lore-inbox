Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311750AbSCNTt5>; Thu, 14 Mar 2002 14:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311751AbSCNTtr>; Thu, 14 Mar 2002 14:49:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10513 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311750AbSCNTth>; Thu, 14 Mar 2002 14:49:37 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Date: 14 Mar 2002 11:48:55 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6qur7$7r6$1@cesium.transmeta.com>
In-Reply-To: <p73bsdrsftu.fsf@oldwotan.suse.de> <E16lT7I-0003uC-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16lT7I-0003uC-00@wagner.rustcorp.com.au>
By author:    Rusty Russell <rusty@rustcorp.com.au>
In newsgroup: linux.dev.kernel
> 
> Sorry, I think one macro to get the address, one to get the contents
> is a *horrible* interface.
> 

The only other choice -- arguably the right one -- is to add explicit
compiler support.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
