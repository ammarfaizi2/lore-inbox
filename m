Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVHKJrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVHKJrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 05:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVHKJrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 05:47:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21652 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932329AbVHKJrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 05:47:52 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050810234246.GT4006@stusta.de> 
References: <20050810234246.GT4006@stusta.de>  <42F57FCA.9040805@yahoo.com.au> <20050808145430.15394c3c.akpm@osdl.org> <200508110812.59986.phillips@arcor.de> <200508110823.53593.phillips@arcor.de> 
To: Adrian Bunk <bunk@stusta.de>
Cc: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>, David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Thu, 11 Aug 2005 10:46:32 +0100
Message-ID: <27057.1123753592@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> Since this was done only for CacheFS, and Andrew dropped CacheFS from 
> -mm he could drop this patch as well.

I asked him not to. Somewhat at his instigation, I requested that he drop the
filesystem caching patches for the moment. I'm updating them and they'll be
back soon. Taking out this and the other remaining patch means he'll just be
given them back again shortly.

I know you want to ruthlessly trim out anything that isn't used, but please be
patient:-)

David
