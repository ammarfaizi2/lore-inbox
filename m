Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275278AbTHMQVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275279AbTHMQVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:21:35 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:16397 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S275278AbTHMQVe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:21:34 -0400
Subject: Re: 2.6.0-test3-mm2
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Hugh Dickins <hugh@veritas.com>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0308131529200.1558-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0308131529200.1558-100000@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1060791500.456.0.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Aug 2003 13:18:20 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2003-08-13 às 11:32, Hugh Dickins escreveu:
> On Wed, 13 Aug 2003, Con Kolivas wrote:
> > Aug 13 22:54:58 pc kernel: kernel BUG at mm/filemap.c:1930!
> 
> akpm (have you caught a moment when he's asleep?!) already posted
> the fix, saying it's a bogus BUG_ON which can be removed.

 Its working.

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

