Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSBGIHo>; Thu, 7 Feb 2002 03:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSBGIHe>; Thu, 7 Feb 2002 03:07:34 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:3085 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S286207AbSBGIH0>; Thu, 7 Feb 2002 03:07:26 -0500
Date: Thu, 7 Feb 2002 09:07:14 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020207080714.GA10860@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <3C618AFD.7148EEAA@linux-m68k.org> <Pine.LNX.4.33.0202061529280.1714-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0202061529280.1714-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 03:36:01PM -0800, Linus Torvalds wrote:

[...Talking about BitKeeper adoption...]
> That will be very convenient for multiple patches, but at the
> same time that will require more trust in the source, so I'll probably
> keep the "patches as diffs in emails" for the occasional work, and the
> direct BK link for the people I work closest with.

What about people who send you occasionnal patches, and happen to
be using Bitkeeper too ?

Do you still prefer only regular patches from them or you would
accept something generated with a:
	bk send -d torvalds@transmeta.com
(which prepends the bk changeset with the equivalent in unified diff 
format, so you can have the best of both worlds) ?

In the latter case Documentation/SubmittingPatches should be updated
with the proper BitKeeper syntax to use etc.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
