Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315189AbSDWNSP>; Tue, 23 Apr 2002 09:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315194AbSDWNSO>; Tue, 23 Apr 2002 09:18:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39697 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S315189AbSDWNSO>; Tue, 23 Apr 2002 09:18:14 -0400
Date: Tue, 23 Apr 2002 09:16:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre7
In-Reply-To: <20020416204719.A11687@infradead.org>
Message-ID: <Pine.LNX.4.21.0204230916280.3345-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Apr 2002, Christoph Hellwig wrote:

> On Tue, Apr 16, 2002 at 04:17:22PM +0200, Andrea Arcangeli wrote:
> > On Tue, Apr 16, 2002 at 12:50:13AM -0300, Marcelo Tosatti wrote:
> > > <hch@infradead.org> (02/04/15 1.409)
> > > 	[PATCH] unlock buffer_head _after_ end_kio_request
> > 
> > This is wrong.
> 
> Yes.  A short conversation with bcrl even uncovered why it is wrong
> and why my reason for doing it is wrong..
> 
> Marcelo, you you please cset -x this one?

Done.

