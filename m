Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288246AbSACQqT>; Thu, 3 Jan 2002 11:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288241AbSACQqH>; Thu, 3 Jan 2002 11:46:07 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:11279 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288243AbSACQpb>;
	Thu, 3 Jan 2002 11:45:31 -0500
Date: Thu, 3 Jan 2002 14:45:46 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Message-ID: <20020103144546.E25846@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <E16MAp4-00018b-00@starship.berlin> <3C3486C9.8080007@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3486C9.8080007@evision-ventures.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 03, 2002 at 05:28:57PM +0100, Martin Dalecki escreveu:
> >That's good advice and I'm likely to adhere to it - if you can show that 
> >having no spaces between the name of the function and its arguments really 
> >is the accepted practice. 

> It is trust on that. Only the silly GNU indentation style introduced 
> something else. Look at the "core kernel" and
> not the ugly drivers around it.

Specially _not_ the ones in drivers/scsi ;)

/me runs

- Arnaldo
