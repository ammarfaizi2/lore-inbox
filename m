Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313690AbSDPORL>; Tue, 16 Apr 2002 10:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313694AbSDPORK>; Tue, 16 Apr 2002 10:17:10 -0400
Received: from [195.223.140.120] ([195.223.140.120]:29756 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313690AbSDPORJ>; Tue, 16 Apr 2002 10:17:09 -0400
Date: Tue, 16 Apr 2002 16:17:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, hch@infradead.org
Subject: Re: Linux 2.4.19-pre7
Message-ID: <20020416161722.F25328@dualathlon.random>
In-Reply-To: <Pine.LNX.4.21.0204160049130.18896-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 12:50:13AM -0300, Marcelo Tosatti wrote:
> <hch@infradead.org> (02/04/15 1.409)
> 	[PATCH] unlock buffer_head _after_ end_kio_request

This is wrong.

Andrea
