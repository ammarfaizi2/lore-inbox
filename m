Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSKVKXo>; Fri, 22 Nov 2002 05:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSKVKXo>; Fri, 22 Nov 2002 05:23:44 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:4268 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261861AbSKVKXn>; Fri, 22 Nov 2002 05:23:43 -0500
Date: Fri, 22 Nov 2002 08:38:28 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] Latest -rmap15 stuff against 2.4.20-rc2-ac2
Message-ID: <20021122083828.R628@nightmaster.csn.tu-chemnitz.de>
References: <20021121225507.GH20701@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20021121225507.GH20701@stingr.net>; from i@stingr.net on Fri, Nov 22, 2002 at 01:55:07AM +0300
X-Spam-Score: -3.3 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18FB5I-00079B-00*5VzQVgrx182*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2002 at 01:55:07AM +0300, Paul P Komkoff Jr wrote:
> ChangeSet@1.695.1.6, 2002-11-21 16:42:17-02:00, riel@duckman.distro.conectiva
>   first stab at fine-tuning arjan's O(1) VM
[...]
>   - preferentially deactivate file cache pages, if there are many
>     of those

You guys don't know, how much admins have dared to get this
behavior (back).

We will make a lot of admins very happy with that.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
