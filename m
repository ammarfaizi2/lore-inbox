Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVKOCw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVKOCw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVKOCw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:52:56 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:52160 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932298AbVKOCwz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:52:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ChB9kyaFcG2woQGykgil0IHq87Qr0u256u2YUTgTAd0iHr59gNNZdFTvuUwUM89EXvDylT38qQ3qKmoSpJssb4T8pbmRwXI+UTIT217yu0hFruiCaolSMihy2P0ik0ifQXNzQ17axTBDZlAY57029LCsEPr4II+lSKMseJ9rXhA=
Message-ID: <625fc13d0511141852t1daeb059p97e6ef4f535bda20@mail.gmail.com>
Date: Mon, 14 Nov 2005 20:52:55 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [RFC] HOWTO do Linux kernel development
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20051114184205.073692cd.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114220709.GA5234@kroah.com> <20051114221005.GA5539@kroah.com>
	 <625fc13d0511141632k541fe338wb9a51222f4a0f453@mail.gmail.com>
	 <20051114172544.31c87778.pj@sgi.com>
	 <625fc13d0511141816v66317c09r3eb2b7743569a5a1@mail.gmail.com>
	 <20051114184205.073692cd.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/05, Paul Jackson <pj@sgi.com> wrote:
> > Apparently that isn't my forte.
>
> It may well be your forte.  I was commenting on your post, not on you.

How about this:

The goal of the kernel community is to provide the best possible
kernel there is.  When you submit a patch for acceptance, it will be
reviewed on it's technical merits and those alone.  So, what should
you be expecting?

- criticism,
- comments
- requests for change
- requests justification.

Remember, this is part of getting your patch into the kernel.  You
have to be able to take criticism and comments about your patches,
evaluate them at a technical level and either rework your patches or
provide clear and concise reasoning as to why those changes should not
be made.

What should you not do?

- expect your patch to be accepted without question
- become defensive
- ignore comments and resubmit the patch without making any changes
- explain how your project is funded by XYZ and therefore must be
awesome as it is

In a community that is looking for the best technical solution
possible, there will always be differing opinions on how beneficial a
patch is.  You have to be cooperative, and
willing to adapt your idea to fit within the kernel.  Or at least be
willing to prove your idea is worth it.  Remember, being wrong is ok
as long as you are willing to work toward a solution that is right.

josh
