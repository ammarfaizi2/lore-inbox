Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263071AbVF3Ues@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbVF3Ues (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbVF3UW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:22:27 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:60795 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263087AbVF3T5V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:57:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WgbNNtGha/d7K6npKGkwT7y9UjXN6SRAOg9iADrPKaY6qCNJzI4z1ccrGkay2n5y5bdOG4IdDoXnAmE85wFEhw6Ma0hIeLE9vaKuXEJ+HCCPGsmzap6xtPr4PQnY/CHuumzmf6FCZLt+vZDTfXBYpbSM+S5ljyXRqSN3IaBlSjA=
Message-ID: <a4e6962a0506301257827759c@mail.gmail.com>
Date: Thu, 30 Jun 2005 14:57:19 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>
Subject: Re: reiser4 plugins
Cc: Douglas McNaught <doug@mcnaught.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20050630100119.GO11013@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
	 <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local>
	 <20050629135820.GJ11013@nysv.org>
	 <20050629205636.GN16867@khan.acc.umu.se>
	 <20050630100119.GO11013@nysv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/05, Markus   Törnqvist <mjt@nysv.org> wrote:
> 
> >instead of trying to get a monstrosity (albeit a very cool one,
> >conceptually) into the kernel.  Sure, it could be made to work,
> >but not without dropping our Unixness.  And if we do, we should
> >start by looking at Plan 9 =)
> 
> What's wrong with "dropping our Unixness" if it means taking
> an extra step toward Plan 9?
> 
> Why is this a bad idea?
> 

It's not.  For those who don't already know about it: check out the
v9fs project (http://v9fs.sf.net) - we're taking steps of moving the
Linux kernel towards Plan 9 while trying to preserve Unix semantics
where they make sense.

     -eric
