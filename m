Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUH1KaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUH1KaB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUH1KaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:30:00 -0400
Received: from [81.23.229.73] ([81.23.229.73]:6062 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S267415AbUH1K3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 06:29:32 -0400
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: linux-kernel@vger.kernel.org
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Date: Sat, 28 Aug 2004 12:29:10 +0200
User-Agent: KMail/1.6.2
References: <20040826233244.GA1284@isi.edu> <1093628254.15313.14.camel@gonzales> <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408281229.10617.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the constructive site of this:
Does anybody have a clue yet of how hard it will be to reverse engineer the 
protocol from Philips and get this back into the tree again?

On Friday 27 August 2004 20:13, you wrote:
> On Fri, 27 Aug 2004, Xavier Bestel wrote:
> > What if someone steps up and want to maintain and extend this piece of
> > code ? Will you forbid him (as in "not in my tree") ?
>
> I'd suggest you contact the people who have worked on that driver (there's
> certainly people outside of nemosoft, at least according to the
> changelogs) and see what they feel like and try to gauge how much they
> were part of driver development.
>
> I'd _really_ prefer not to step on original authors toes.
>
> Quite frankly, the best option is for people who love the driver to plead
> with the author(s). It's totally pointless to flame him/them, that will
> just irritate them and make them less likely to be inclined to say "sure,
> go ahead and maintain the old driver".
>
> But Greg is right - we don't keep hooks that are there purely for binary
> drivers. If somebody wants a binary driver, it had better be a whole
> independent thing - and it won't be distributed with the kernel.
>
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
