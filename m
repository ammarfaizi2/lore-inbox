Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTFGXLR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 19:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbTFGXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 19:11:17 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:8841 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264009AbTFGXLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 19:11:17 -0400
Date: Sat, 7 Jun 2003 14:56:33 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: [FUN] Re: [PATCH] Move BUG/BUG_ON/WARN_ON to asm headers
Message-ID: <20030607145633.V626@nightmaster.csn.tu-chemnitz.de>
References: <16097.56616.35782.882995@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <16097.56616.35782.882995@argo.ozlabs.ibm.com>; from paulus@samba.org on Sat, Jun 07, 2003 at 10:40:08PM +1000
X-Spam-Score: -3.7 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19On3M-0004Oi-00*RCX7/1M.AnA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sat, Jun 07, 2003 at 10:40:08PM +1000, Paul Mackerras wrote:
> +struct bug_entry *module_find_bug(unsigned long bugaddr)

A wet dream of many driver writers has come true: A function,
which finds the bug in their module ;-)

Very amused

Ingo Oeser
