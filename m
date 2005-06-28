Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVF1Nyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVF1Nyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 09:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVF1Nyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 09:54:35 -0400
Received: from [141.211.252.224] ([141.211.252.224]:18864 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261759AbVF1NyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 09:54:20 -0400
Date: Tue, 28 Jun 2005 15:54:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: David Masover <ninja@slaphack.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: cryptocompress [was Re: reiser4 plugins]
Message-ID: <20050628135408.GA6302@elf.ucw.cz>
References: <42BAC304.2060802@slaphack.com> <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >                    and vfat people may decide they want cryptocompress,
> 
> I'm sure they don't, because it is mostly for Windows and assorted devices
> (pendrives, digital cameras, ...) compatibility.

Actually cryptocompress for vfat *would* be nice; pen drives are
small, slow, and likely to be lost/stolen. That makes them very nice
candidates for cryptocompress ;-).
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
