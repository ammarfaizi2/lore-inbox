Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273052AbTGaNvp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273053AbTGaNvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:51:44 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:4549
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S273052AbTGaNvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:51:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Szonyi Calin" <sony@etc.utt.ro>
Subject: Re: [PATCH] O11int for interactivity
Date: Thu, 31 Jul 2003 23:56:19 +1000
User-Agent: KMail/1.5.2
Cc: <linux-kernel@vger.kernel.org>
References: <200307301038.49869.kernel@kolivas.org> <200307301108.53904.kernel@kolivas.org> <23496.194.138.39.55.1059659754.squirrel@webmail.etc.utt.ro>
In-Reply-To: <23496.194.138.39.55.1059659754.squirrel@webmail.etc.utt.ro>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307312356.19364.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 23:55, Szonyi Calin wrote:
> Con Kolivas said:
> > On Wed, 30 Jul 2003 10:55, Con Kolivas wrote:
> >> On Wed, 30 Jul 2003 10:38, Con Kolivas wrote:
> >> > Update to the interactivity patches. Not a massive improvement but
> >>
> >> more smoothing of the corners.
> >
> > Here is O11.1int which backs out that part. This was only of minor help
> > anyway so backing it out still makes the other O11 changes worthwhile.
> >
> > A full O11.1 patch against 2.6.0-test2 is available on my website.
>
> A little bit better than O10 but mplayer still skips frames while
> doind a make bzImage in the background

Can you tell me what top shows mplayer scores in the PRI column during all 
this?

Con

