Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290656AbSBLAwl>; Mon, 11 Feb 2002 19:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290657AbSBLAwc>; Mon, 11 Feb 2002 19:52:32 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:34825 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S290656AbSBLAwW>; Mon, 11 Feb 2002 19:52:22 -0500
From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
        "Dan Mann" <mainlylinux@attbi.com>
Cc: "Jaroslav Kysela" <perex@perex.cz>,
        "ALSA development" <alsa-devel@alsa-project.org>,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: RE: [Alsa-devel] Re: ALSA patch for 2.5.4
Date: Tue, 12 Feb 2002 01:03:59 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFGEFKCAAA.James@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3C686066.91B06D84@mandrakesoft.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am pretty sure that Linus will not want to be copied on all these emails.
The result is likely to be that he reads none of them.
I don't think that at this stage we should be talking to Linus Torvalds at
all. He is probably too busy.
I think that a much better approach would be to talk to the current kernel
oss sound developers, and get alsa checked into the kernel via them.
I think that one person should be responsible for linux kernel sound, so
that Linus Torvalds does not have to ignore so much email due to overload.

When I have too many emails in my email box, single short(5 lines) emails
get read, whole discussion threads get left unread.
So a simple "Here is the final alsa sound patch for the kernel" from someone
Linus already knows would in my view be more successful.

My 2 cents.

James



> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Jeff Garzik
> Sent: 12 February 2002 00:23
> To: Dan Mann
> Cc: Jaroslav Kysela; ALSA development; LKML; Linus Torvalds
> Subject: [Alsa-devel] Re: ALSA patch for 2.5.4
>
>
> Dan Mann wrote:
> > On Mon, 2002-02-11 at 09:16, Jaroslav Kysela wrote:
> > >       I repeat myself but anyway. We are open to any suggestions and
> > > ideas for this kernel integration patch. Unfortunately, Linus has not
> > > approved this directory tree and he is not talking with us at
> the time.
> > > It seems that BIO changes are over, but he's probably busy enough to
> > > ignore our e-mails with co-operation requests.
>
> > There are at least 2 reasons that I can see why Linus probably won't
> > accept your patch:
> >
> >         1. It is not an inline text attachment (it is a URL).
> >         2. It is 79,000 lines long
>
> Well, merging ALSA is going to be one big mother of a patch no matter
> how you slice it :)
>
> But I agree, it would be nice for the patch to be broken up into steps,
> ie. first patch moves OSS drivers into new location, second patch adds
> infrastructure, third patch adds the 1001 drivers that ALSA supports :)
>
> Also if the ALSA guys wanted to experiment with BK, that would be a
> great way to do the merge.
>
> 	Jeff
>
>
>
> --
> Jeff Garzik      | "I went through my candy like hot oatmeal
> Building 1024    |  through an internally-buttered weasel."
> MandrakeSoft     |             - goats.com
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

