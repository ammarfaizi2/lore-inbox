Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUEaGZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUEaGZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 02:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUEaGZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 02:25:00 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:33321 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S264569AbUEaGY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 02:24:59 -0400
Date: Mon, 31 May 2004 08:27:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: makefile fix
Message-ID: <20040531062726.GB2216@mars.ravnborg.org>
Mail-Followup-To: carbonated beverage <ramune@net-ronin.org>,
	linux-kernel@vger.kernel.org
References: <20040529205109.GA27792@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529205109.GA27792@net-ronin.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 01:51:09PM -0700, carbonated beverage wrote:
> Every time I build on the Ultra, I get a file called "64" in the top-level
> directory.  Here's a small patch to make it do the right thing(tm).
> 
> Note, I'm using ash as my /bin/sh.  Works for me, at least, with bash and
> ash.

Patch is already in Linus' tree. Christoph digged it out of Debian.

	Sam
