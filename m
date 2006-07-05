Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWGET2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWGET2A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWGET2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:28:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22488 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964959AbWGET17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:27:59 -0400
Subject: Re: [PATCH] Limit VIA and SIS AGP choices to x86
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060705192147.GF1877@redhat.com>
References: <20060705175725.GL1605@parisc-linux.org>
	 <20060705192147.GF1877@redhat.com>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 21:27:56 +0200
Message-Id: <1152127676.3201.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 15:21 -0400, Dave Jones wrote:
> On Wed, Jul 05, 2006 at 11:57:25AM -0600, Matthew Wilcox wrote:
>  > 
>  > As far as I am aware, Alpha, PPC and IA64 don't have VIA or SIS AGP
>  > chipsets available.
> 
> VIA has turned up on PPC (some Apple notebooks).

only the southbridge... agp is a northbridge thing...

