Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291861AbSBARBz>; Fri, 1 Feb 2002 12:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291858AbSBARBp>; Fri, 1 Feb 2002 12:01:45 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:9694 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S291857AbSBARBj>; Fri, 1 Feb 2002 12:01:39 -0500
Date: Fri, 1 Feb 2002 11:01:37 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201110137.B2560@asooo.flowerfire.com>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1012582401.813.1.camel@phantasy>; from rml@tech9.net on Fri, Feb 01, 2002 at 11:53:20AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 11:53:20AM -0500, Robert Love wrote:
| On Fri, 2002-02-01 at 04:17, Ken Brownfield wrote:
| Most of the useful fixes actually came in a large update from Andreas
| Dilger.  Perhaps he would have some insight, too.

Ah, my apoligies then.

| Exhausting entropy to zero under high use is not uncommon (that is a
| motivation for my netdev-random patch).  What boggles me is why it does
| not regenerate?

Yeah -- slow entropy is "acceptable", but blocking until a reboot is rather unacceptable. ;)

Thx much,
-- 
Ken.
brownfld@irridia.com

| 
| 	Robert
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
