Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276857AbRJCEYe>; Wed, 3 Oct 2001 00:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276858AbRJCEYY>; Wed, 3 Oct 2001 00:24:24 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:63900 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S276857AbRJCEYT>; Wed, 3 Oct 2001 00:24:19 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200110030423.FAA07107@mauve.demon.co.uk>
Subject: Re: [PATCH] Stateful Magic Sysrq Key
To: linux-kernel@vger.kernel.org
Date: Wed, 3 Oct 2001 05:23:56 +0100 (BST)
In-Reply-To: <20011002185016.90E271F9BA@zion.rivenstone.net> from "Joseph Fannin" at Oct 02, 2001 07:44:10 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tuesday 02 October 2001 03:02, Ian Stirling wrote:
> > > The following patch is a reworked patch which originated from Amazon.
> > > It makes the sysrq key stateful, giving it the following behaviours:
> >
> > IMO, this is needed for broken keyboards, but in this exact form will
> > cause problems for those without them.
<snip>
>     This behavior *is* optional -- both as a compile-time option and as a
> value in /proc/sys.

Sorry, I diddn't see it, I had a quick scan, and it seemed to me that
it was a replacement for the current magic-sysrq, not an alternative.
