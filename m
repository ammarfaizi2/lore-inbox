Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbTLaWI5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbTLaWI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:08:56 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:8974 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S265231AbTLaWI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:08:56 -0500
Date: Wed, 31 Dec 2003 20:19:55 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.0 - 2003-12-29.22.30) - 5 New warnings (gcc 3.2.2)
Message-ID: <20031231221955.GX28868@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <200312301108.hBUB8lxF021053@cherrypit.pdx.osdl.net> <20031231215728.GA745@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231215728.GA745@penguin.localdomain>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 31, 2003 at 10:57:28PM +0100, Marcel Sebek escreveu:
> On Tue, Dec 30, 2003 at 03:08:47AM -0800, John Cherry wrote:
> > drivers/net/wan/cycx_drv.c:430: warning: unsigned int format, long unsigned int arg (arg 3)

Thanks, but 2.6.1-rc1 has this patch sent by Alan some weeks ago
