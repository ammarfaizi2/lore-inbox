Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWAYSQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWAYSQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWAYSQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:16:24 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:22686 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932088AbWAYSQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:16:23 -0500
Subject: Re: 2.6.16-rc1-mm3
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43D7AB49.2010709@shadowen.org>
References: <20060124232406.50abccd1.akpm@osdl.org>
	 <43D785E1.4020708@shadowen.org>
	 <84144f020601250644h6ca4e407q2e15aa53b50ef509@mail.gmail.com>
	 <43D7AB49.2010709@shadowen.org>
Date: Wed, 25 Jan 2006 20:16:21 +0200
Message-Id: <1138212981.8595.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 16:46 +0000, Andy Whitcroft wrote:
> Pekka Enberg wrote:
> > Does reverting the following patch make the panic go away?
> > 
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm3/broken-out/slab-cache_estimate-cleanup.patch
> 
> No luck with that one ... I'll try the others you suggested.

Does vanilla 2.6.16-rc1 work for you? The oops definitely makes me think
it's slab related but the other patches don't seem likely suspects.

			Pekka

