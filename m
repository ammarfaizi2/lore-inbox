Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTIDQJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbTIDQJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:09:20 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:11667 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265080AbTIDQJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:09:14 -0400
Date: Thu, 4 Sep 2003 18:09:11 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@redhat.com>, Matthias Andree <matthias.andree@gmx.de>,
       torvalds@osdl.org, marcelo.tosatti@cyclades.com.br, samel@mail.cz
Subject: Re: BK-kernel-tools/shortlog update
Message-ID: <20030904160911.GA6694@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Dave Jones <davej@redhat.com>, torvalds@osdl.org,
	marcelo.tosatti@cyclades.com.br, samel@mail.cz
References: <20030903233333.C8468854D0@merlin.emma.line.org> <20030904160511.GB3357@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904160511.GB3357@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Sep 2003, Dave Jones wrote:

> On Thu, Sep 04, 2003 at 01:33:33AM +0200, Matthias Andree wrote:
>  >  'davej:codmonkey.org.uk' => 'Dave Jones',
> 
> This one looks fishy.

Are you sure this hasn't ever been used by accident? Then I'll drop it.

>  >  'davej:suse.de' => 'Dave Jones',
> 
> You can nuke this one, I won't be using it again.
> 
>  >  'davej:tetrachloride.(none)' => 'Dave Jones',
> 
> Ditto, this box is no more.

I'm reluctant to drop addresses. Someone might want to format older log
entries; considering that the software isn't usually up to date when
Marcelo releases a kernel (Linus seems to care, Marcelo doesn't ever add
data or request adding data - maybe I should ask him), that's where we
stand.
