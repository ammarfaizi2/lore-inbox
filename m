Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbUAQVsA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 16:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUAQVsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 16:48:00 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:3169 "EHLO
	mwinf0801.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265834AbUAQVr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 16:47:58 -0500
Date: Sat, 17 Jan 2004 22:47:56 +0100
From: Romain Lievin <romain@rlievin.dyndns.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] "gconfig" removed root folder...
Message-ID: <20040117214756.GA30465@rlievin.dyndns.org>
References: <1074177405.3131.10.camel@oebilgen> <20040115214416.GA25409@rlievin.dyndns.org> <20040116161440.GC30349@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040116161440.GC30349@louise.pinerecords.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 16, 2004 at 05:14:41PM +0100, Tomas Szepe wrote:
> On Jan-15 2004, Thu, 22:44 +0100
> Romain Lievin <romain@rlievin.dyndns.org> wrote:
> 
> > +	if(stat(fn, &sb) == -1) return;	
> 
> Codingstyle inconsistency.

What should I write then ? Your piece of advice may make me better.

> 
> Contrary to popular belief, 'if' is _not_ a function nor is it a macro.

Thanks, Romain.
-- 
Romain Li�vin (roms):         <roms@tilp.info>
Web site:                     http://tilp.info
"Linux, y'a moins bien mais c'est plus cher !"






