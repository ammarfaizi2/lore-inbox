Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWHJUir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWHJUir (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWHJUiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:38:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:42118 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751615AbWHJUiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:38:01 -0400
Date: Thu, 10 Aug 2006 13:37:36 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Robert Love <rlove@rlove.org>, Shem Multinymous <multinymous@gmail.com>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Jean Delvare <khali@linux-fr.org>, hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/12] ThinkPad embedded controller and hdaps drivers (version 2)
Message-ID: <20060810203736.GA15208@suse.de>
References: <1155203330179-git-send-email-multinymous@gmail.com> <acdcfe7e0608100646s411f57ccse54db9fe3cfde3fb@mail.gmail.com> <20060810131820.23f00680.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810131820.23f00680.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 01:18:20PM -0700, Andrew Morton wrote:
> On Thu, 10 Aug 2006 09:46:47 -0400
> "Robert Love" <rlove@rlove.org> wrote:
> 
> > Patches look great and I am glad someone has apparently better access
> > to hardware specs than I did.
> 
> This situation is still a concern.  From where did this additional register
> information come?
> 
> Was it reverse-engineered?  If so, by whom and how can we satisfy ourselves
> of this?
> 
> Was it from published documents?
> 
> Was it improperly obtained from NDA'ed documentation?
> 
> Presumably the answer to the third question will be "no", but if
> challenged, how can we defend this assertion?
> 
> So hm.  We're setting precedent here and we need Linus around to resolve
> this.  Perhaps we can ask "Shem" to reveal his true identity to Linus (and
> maybe me) privately and then we proceed on that basis.  The rule could be
> "each of the Signed-off-by:ers should know the identity of the others".

For what it's worth, I'm not going to be handling these patches at all
(normally the hwmon patches go to Linus through Jean and then through
me.)

If the original developer does not want to work in the open like the
rest of us, I can respect that, but unfortunatly I can't accept the risk
of accepting their code.

And no, this is not "been beaten over the head by IP lawyers for three
years about risks like this" portion of me talking, although that side
does have a lot he could say about this situation...

thanks,

greg k-h
