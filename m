Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbSKUBHg>; Wed, 20 Nov 2002 20:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266259AbSKUBHg>; Wed, 20 Nov 2002 20:07:36 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:33039 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266257AbSKUBHf>; Wed, 20 Nov 2002 20:07:35 -0500
Date: Wed, 20 Nov 2002 23:14:36 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Robert Love <rml@tech9.net>
Cc: Rusty Lynch <rusty@linux.co.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [Coding style question] XXX_register or register_XXX
Message-ID: <20021121011436.GF28717@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Robert Love <rml@tech9.net>, Rusty Lynch <rusty@linux.co.intel.com>,
	linux-kernel@vger.kernel.org
References: <001701c290ef$8417f020$94d40a0a@amr.corp.intel.com> <1037840908.1253.3178.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037840908.1253.3178.camel@phantasy>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 20, 2002 at 08:08:28PM -0500, Robert Love escreveu:
> On Wed, 2002-11-20 at 18:49, Rusty Lynch wrote:
> > int foo_register(&something);
> > int foo_unregister(&something);
 
> But I prefer this - I like there to be a namespace for a given subsystem
> and for it to be a prefix.

100% agreed. Just look at LLC 8) And yes, the big names was procom's fault,
but the way it is structured... I'd love somebody to come up with something
that makes it smaller 8)

- Arnaldo
