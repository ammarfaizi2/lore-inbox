Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSJPQac>; Wed, 16 Oct 2002 12:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265170AbSJPQac>; Wed, 16 Oct 2002 12:30:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61149 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265168AbSJPQab>; Wed, 16 Oct 2002 12:30:31 -0400
Date: Wed, 16 Oct 2002 14:36:14 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrew Morton <akpm@digeo.com>
Cc: David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] do_generic_file_read / readahead adjustments
In-Reply-To: <3DAD917E.B62ABDDA@digeo.com>
Message-ID: <Pine.LNX.4.44L.0210161435470.1648-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Andrew Morton wrote:
> David Howells wrote:
> >
> > The attached patch does the following three things:
>
> Seems sensible.  Is there something out there which actually uses this?

I think David has a few things up his sleeve.  The patch looks
sensible.

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

