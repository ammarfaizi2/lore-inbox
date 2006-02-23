Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWBWPlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWBWPlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWBWPlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:41:36 -0500
Received: from smtp.enter.net ([216.193.128.24]:14096 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751462AbWBWPlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:41:35 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: [OT] portable Makefiles (was: CD writing in future Linux  (stirring up a hornets' nest))
Date: Thu, 23 Feb 2006 10:42:01 -0500
User-Agent: KMail/1.8.1
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <20060222140528.GB13283@merlin.emma.line.org> <43FDA779.nailFHQ21G57C@burner>
In-Reply-To: <43FDA779.nailFHQ21G57C@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231042.01649.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 07:15, Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> > Joerg Schilling schrieb am 2006-02-22:
> > > > - run Solaris' /usr/{ccs,xpg4}/bin/make
> > > >   to find out if your Makefile is portable
> > >
> > > Solaris make does not write useful error messages in case of
> > > non-portable makefiles.
> >
> > Sun Microsystems do not advertise their make tool as Makefile
> > portability validator.  Note the difference: each tool is held to its
> > own standards.
>
> I do not advertize smake as makefile validator either.
>
> It would help a lot, if people on LKML would not repeatedly impute me
> things I never said....
>
>
> Smake helps to find non-portable code, this is something completely
> different!

Umm - Joerg, you just stepped on your own toes there. A makefile validator 
does exactly that - helps people find non-portable code. You're fighting a 
losing battle when you claim one thing then say something that proves it 
false.

DRH

