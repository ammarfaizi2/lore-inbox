Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288265AbSACRHJ>; Thu, 3 Jan 2002 12:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288262AbSACRHA>; Thu, 3 Jan 2002 12:07:00 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:31248 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287289AbSACRGr>;
	Thu, 3 Jan 2002 12:06:47 -0500
Date: Thu, 3 Jan 2002 15:07:05 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Message-ID: <20020103150705.F25846@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <E16MAp4-00018b-00@starship.berlin> <20020103143630.D25846@conectiva.com.br> <E16MBIw-00018y-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16MBIw-00018y-00@starship.berlin>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 03, 2002 at 06:05:19PM +0100, Daniel Phillips escreveu:
> On January 3, 2002 05:36 pm, Arnaldo Carvalho de Melo wrote:
> > Maybe CodingStyle should have an entry for this, I'd vote for this style:
> >
> > static inline struct inode *new_inode(struct super_block *sb)
> 
> OK, I'll revise it to that style.  Shall we start an official janitor's style
> guide? ;-)

Nah, I'll try and submit some patches do CodingStyle, for discussion. Hey,
people here _love_ to discuss important things like coding style, dontcha?
8)

- Arnaldo
