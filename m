Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265584AbTFRWuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTFRWuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:50:18 -0400
Received: from aneto.able.es ([212.97.163.22]:21490 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S265584AbTFRWrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:47:41 -0400
Date: Thu, 19 Jun 2003 01:01:36 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [RFC][PATCH] CONFIG_NR_CPUS for 2.4.21
Message-ID: <20030618230136.GG3768@werewolf.able.es>
References: <20030618222336.GC3768@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030618222336.GC3768@werewolf.able.es>; from jamagallon@able.es on Thu, Jun 19, 2003 at 00:23:36 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.19, J.A. Magallon wrote:
> Hi all...
> 
> This adds support for defining max CPU number at compile time. It is safe
> for old .configs, because it defaults to current fixed max values.
> 
> Could you consider for applying ?
> 

Oops, credits for this should go to (and possible comments/reject come
from) Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
