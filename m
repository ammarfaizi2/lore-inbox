Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSEXDzj>; Thu, 23 May 2002 23:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSEXDzi>; Thu, 23 May 2002 23:55:38 -0400
Received: from panda.sul.com.br ([200.219.150.4]:1296 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S314083AbSEXDzh>;
	Thu, 23 May 2002 23:55:37 -0400
Date: Thu, 23 May 2002 03:55:13 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include buffer_head.h in actual users instead of fs.h (10/10)
Message-ID: <20020523065513.GI1144@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020523132746.J24361@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 23, 2002 at 01:27:46PM +0100, Christoph Hellwig escreveu:
> No more need to include buffer_head.h in fs.h.  Finally.

Whee! Congratulations :-)

- Arnaldo
