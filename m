Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbTJPQOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 12:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbTJPQOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 12:14:17 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:44299 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S263196AbTJPQON convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 12:14:13 -0400
Subject: Re: 2.6.0-test7-mm1
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20031015214004.GC723@holomorphy.com>
References: <20031015013649.4aebc910.akpm@osdl.org>
	 <1066232576.25102.1.camel@telecentrolivre>
	 <20031015165508.GA723@holomorphy.com> <20031015214004.GC723@holomorphy.com>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1066317063.2601.3.camel@telecentrolivre>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 16 Oct 2003 13:11:03 -0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

Em Qua, 2003-10-15 às 19:40, William Lee Irwin III escreveu:
> On Wed, Oct 15, 2003 at 09:55:08AM -0700, William Lee Irwin III wrote:
> > Okay, this one's me. I should have tried DEBUG_PAGEALLOC when testing.
> 
> I can't reproduce it here, can you retry with the invalidate_inodes-speedup
> patch backed out?

yes, it works without invalidate_inodes-speedup.

(sorry for the delay).

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

