Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284842AbRL3UQD>; Sun, 30 Dec 2001 15:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284820AbRL3UPy>; Sun, 30 Dec 2001 15:15:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:46829 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S284755AbRL3UPl> convert rfc822-to-8bit; Sun, 30 Dec 2001 15:15:41 -0500
Date: Sun, 30 Dec 2001 21:15:33 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Christoph Hellwig <hch@caldera.de>
cc: linux-kernel@vger.kernel.org, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: State of the new config & build system
In-Reply-To: <20011230145831.A30561@caldera.de>
Message-ID: <Pine.NEB.4.43.0112302106050.17750-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Christoph Hellwig wrote:

> On Fri, Dec 28, 2001 at 03:39:02PM -0500, Eric S. Raymond wrote:
> > It may be that the reason our experiences have been different is because we
> > focus on different target languages.  But I think my experience is an
> > existence proof that there *is* demand for localization and that meeting
> > it can have useful results.
>
> Is your native language something different thæn english or Al's?
>
> Localization for technical messages sucks.  badly.
> Just take a look at a european computer magazine, you will find lots of
> english words in the text because there is no german/frensh/whatever
> one.  Trying to use different grammar doesn't help the understanding.

For some people it helps when the text is in e.g. German although the
technical words are still English.

The most important point I see is: If the tanslation works similar to
gettext, IOW there's a seperate directory that contains the complete
translations I can't see problem for the "normal" kernel hacker: You don't
have to care about the translations but if someone wants to provide a
translation to e.g. Esperanto he can always do so by adding a file with
the translated texts. People like you and me who prefer the English
version can always use it but other people who prefer the translated
messages can use them instead.

> 	Christoph

cu
Adrian


