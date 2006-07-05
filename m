Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWGETg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWGETg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWGETg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:36:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42715 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965003AbWGETgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:36:25 -0400
Date: Wed, 5 Jul 2006 15:36:18 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Limit VIA and SIS AGP choices to x86
Message-ID: <20060705193618.GH1877@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20060705175725.GL1605@parisc-linux.org> <20060705192147.GF1877@redhat.com> <1152127676.3201.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152127676.3201.62.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 09:27:56PM +0200, Arjan van de Ven wrote:
 > On Wed, 2006-07-05 at 15:21 -0400, Dave Jones wrote:
 > > On Wed, Jul 05, 2006 at 11:57:25AM -0600, Matthew Wilcox wrote:
 > >  > 
 > >  > As far as I am aware, Alpha, PPC and IA64 don't have VIA or SIS AGP
 > >  > chipsets available.
 > > 
 > > VIA has turned up on PPC (some Apple notebooks).
 > 
 > only the southbridge... agp is a northbridge thing...

Maybe my memory is flaky, but I'm sure I recall a VIA
northbridge in the ibook.

benh ?

		Dave

-- 
http://www.codemonkey.org.uk
