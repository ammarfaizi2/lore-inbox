Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSEMKef>; Mon, 13 May 2002 06:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSEMKee>; Mon, 13 May 2002 06:34:34 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:39438 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S312296AbSEMKee>; Mon, 13 May 2002 06:34:34 -0400
Date: Sun, 12 May 2002 17:41:40 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020512204140.GB7593@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org> <abmi0f$ugh$1@penguin.transmeta.com> <20020512203103.GA9087@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 12, 2002 at 09:31:03PM +0100, Dr. David Alan Gilbert escreveu:
> Perhaps insisting that each check in message includes a single line (sub
> 60 chars) description; could turn those into description : name and
> remove dupes?

That'd be nice indeed, like %{summary} and %{description} in rpm spec files 8)

A simple script would just get the line with '^Summary:' and generate the
one page "executive" summary...

Now to wait for the non auto part of the story: discipline of kernel hackers,
erm, it seems we'll need an human doing the summary... ;(

- Arnaldo
