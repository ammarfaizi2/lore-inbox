Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbUJYJIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUJYJIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbUJYJIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:08:01 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:30475 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261705AbUJYJHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:07:39 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reduce top(1) CPU usage by an order of magnitude
Date: Mon, 25 Oct 2004 12:07:24 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, pmarques@grupopie.com, torvalds@osdl.org
References: <200410251020.01932.vda@port.imtp.ilyichevsk.odessa.ua> <20041025003600.2f03c1fd.akpm@osdl.org>
In-Reply-To: <20041025003600.2f03c1fd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410251207.24075.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 10:36, Andrew Morton wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> >
> > Patch is not mine, Paulo Marques <pmarques@grupopie.com>
> >  wrote it.
> > 
> >  I tested in on 2.6.9-rc2. top(1) CPU usage went from ~40% to ~4%
> >  (yes, test box is a rather old piece of junk).
> > 
> >  The patch applies cleanly to 2.6.9.
> 
> umm, this patch has been in -mm for six weeks, and in Linus's kernel for
> one week.

Good.

Sorry for the noise.
--
vda

