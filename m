Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270661AbRHSRU2>; Sun, 19 Aug 2001 13:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270668AbRHSRUH>; Sun, 19 Aug 2001 13:20:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57874 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270661AbRHSRUD>; Sun, 19 Aug 2001 13:20:03 -0400
Date: Sun, 19 Aug 2001 14:20:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Chris Oxenreider <oxenreid@state.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.9 build fails on Mandrake 8.0
Message-ID: <20010819142008.C2580@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Chris Oxenreider <oxenreid@state.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SV4.4.10.10108191150090.1226-100000@dorthy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.SV4.4.10.10108191150090.1226-100000@dorthy>; from oxenreid@state.net on Sun, Aug 19, 2001 at 12:13:52PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 19, 2001 at 12:13:52PM -0500, Chris Oxenreider escreveu:
> 
> Help.
> On a freshly installed system using a version of Mandrake 8.0 from the 
> free 'iso' images on the linux-mandrake sight this is what happens:

add 

#include <linux/kernel.h>

IIRC this will do the trick, getting the min definition from kernel.h

- Arnaldo
