Return-Path: <linux-kernel-owner+w=401wt.eu-S932624AbWLMJMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWLMJMG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWLMJMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:12:06 -0500
Received: from styx.suse.cz ([82.119.242.94]:37473 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932628AbWLMJMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:12:03 -0500
X-Greylist: delayed 1341 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 04:12:03 EST
Date: Wed, 13 Dec 2006 09:49:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Cal Peake <cp@absolutedigital.net>, trivial@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Note subscribers only lists for input subsystem
Message-ID: <20061213084940.GD5493@suse.cz>
References: <Pine.LNX.4.64.0612121157110.4219@lancer.cnet.absolutedigital.net> <d120d5000612120940s16f26b27p4b9e0792038693b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000612120940s16f26b27p4b9e0792038693b6@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 12:40:35PM -0500, Dmitry Torokhov wrote:
> On 12/12/06, Cal Peake <cp@absolutedigital.net> wrote:
> >According to Dmitry in <http://lkml.org/lkml/2006/10/17/280>, the input
> >list is subscribers only. I'm assuming here that both are but a
> >confirmation would be nice... :)
> >
> >From: Cal Peake <cp@absolutedigital.net>
> >
> >Annotate the MAINTAINERS file to reflect the subscribers only nature of
> >the input mailing lists.
> >
> 
> Actually I'd rather have them open, let's see if Vojtech could change
> that... The main problem is that not only input lists accept posts
> from subscribers only but they silently drop everything else. Maybe
> dropping only HTML posts would be a decent compromise.
 
Ok. I'll take a look at it.

-- 
Vojtech Pavlik
Director SuSE Labs
