Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTJXIsj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 04:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTJXIsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 04:48:39 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:33032 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262078AbTJXIsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 04:48:38 -0400
Date: Fri, 24 Oct 2003 05:48:23 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Emmanuel Fleury <fleury@cs.auc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel threads and SMP programming
Message-ID: <20031024084823.GA28523@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Emmanuel Fleury <fleury@cs.auc.dk>, linux-kernel@vger.kernel.org
References: <1066984101.5097.26.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066984101.5097.26.camel@rade7.s.cs.auc.dk>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 24, 2003 at 10:28:21AM +0200, Emmanuel Fleury escreveu:
> Hi,
> 
> I have been googling a bit and looking on kernelnewbies, but I didn't
> find any documentation on how to code kernel-space programs for SMP...
> 
> Can somebody give me a hint ?

http://www.linux-mag.com/2000-12/gear_01.html

Perhaps outdated, haven't checked, but this is an article by Alessandro
Rubini with the suggestive title "The Design of an In-Kernel Server", so
what was you using as keywords on google? :-)

- Arnaldo
