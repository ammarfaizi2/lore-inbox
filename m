Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269249AbTGJMO7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbTGJMO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:14:59 -0400
Received: from [200.230.190.107] ([200.230.190.107]:43780 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S269247AbTGJMO4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:14:56 -0400
Subject: Re: Forking shell bombs
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3F0B2CE6.8060805@nni.com>
References: <20030708193401.24226.95499.Mailman@lists.us.dell.com>
	 <20030708202819.GM1030@dbz.icequake.net>  <3F0B2CE6.8060805@nni.com>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1057840372.12494.7.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 10 Jul 2003 09:32:52 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2003-07-08 às 17:43, jhigdon escreveu:

> Have you tried this on any 2.5.x kernels? Just curious to see what it 
> does, I plan on giving it a go later.

Athlon 1.0GHz with 1GB of memory running 2.5.74-bk6:

$ ulimit -u
2047

The system does not freeze, it becomes slow, but in some
seconds becomes normal.

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

