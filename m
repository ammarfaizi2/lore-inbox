Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWA3VAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWA3VAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWA3VAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:00:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964984AbWA3VAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:00:31 -0500
Date: Mon, 30 Jan 2006 13:00:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060130130007.4925e3ed.akpm@osdl.org>
In-Reply-To: <200601301620.49199.a1426z@gawab.com>
References: <20060129144533.128af741.akpm@osdl.org>
	<200601301620.49199.a1426z@gawab.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi <a1426z@gawab.com> wrote:
>
> Andrew Morton wrote:
> > - Various other random bits and pieces.  Things have been pretty quiet
> >   lately - most activity seems to be concentrated about putting bugs into
> > the various subsystem trees.
> 
> Does it fix the DRM_i810 hang during a suspend-to-ram/disk cycle?
> 

I don't know - I don't watch every patch which goes into 49 different
trees.  Did you try it?
