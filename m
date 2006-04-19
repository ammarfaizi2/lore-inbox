Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWDSPTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWDSPTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWDSPTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:19:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60120 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750839AbWDSPTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:19:09 -0400
Subject: RE: searching exported symbols from modules
From: Arjan van de Ven <arjan@infradead.org>
To: Antti Halonen <antti.halonen@secgo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <963E9E15184E2648A8BBE83CF91F5FAF5154DF@titanium.secgo.net>
References: <963E9E15184E2648A8BBE83CF91F5FAF5154DF@titanium.secgo.net>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 17:17:56 +0200
Message-Id: <1145459877.3085.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 17:54 +0300, Antti Halonen wrote:
> Hi Arjan,
> 
> Thanks for your response.
> 
> > they still are... but.. very often if you want to do this you have a
> > crooked design, you were very vague about what you are really trying
> to
> > achieve (you only described your solution, not the problem)
> 
> The problem is that I cannot seem to have access to the module linked
> list. Ie. I want to traverse the linked list who's nodes contain module
> structures.
> 
> Or
> 
> Access to some global symbol table would be helpful as well. Where's
> listed the symbol address and name. Same stuff which is found at
> /proc/kallsyms.

but to what purpose?
what on earth do you need this for?
Again you talk about solutions not about the problem you're trying to
solve.


