Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbTJBSdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTJBSdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:33:41 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:43021 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S263457AbTJBSdj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:33:39 -0400
Subject: Re: 2.6.0-test6-mm2
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20031002080335.0f75fade.akpm@osdl.org>
References: <20031002022341.797361bc.akpm@osdl.org>
	 <1065102346.14567.12.camel@telecentrolivre>
	 <20031002080335.0f75fade.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1065119384.20375.1.camel@telecentrolivre>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 02 Oct 2003 15:29:44 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2003-10-02 às 12:03, Andrew Morton escreveu:
> Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br> wrote:
> >
> > Em Qui, 2003-10-02 às 06:23, Andrew Morton escreveu:
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm2/
> > 
> >  getting this with gcc-3.2:
> > 
> >  net/core/flow.c:406: warning: type defaults to `int' in declaration of `EXPORT_SYMBOL'
> >  net/core/flow.c:406: warning: parameter names (without types) in function declaration
> >  net/core/flow.c:406: warning: data definition has no type or storage class
> >  net/core/flow.c:407: warning: type defaults to `int' in declaration of `EXPORT_SYMBOL'
> >  net/core/flow.c:407: warning: parameter names (without types) in function declaration
> >  net/core/flow.c:407: warning: data definition has no type or storage class
> 
> It works OK for me, and flow.c correctly includes module.h.  Could you
> double-check that your tree is not damaged in some manner?

 yes, you right.

 sorry for the bad report.

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

