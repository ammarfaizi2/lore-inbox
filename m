Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVGOVrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVGOVrF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 17:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVGOVrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 17:47:05 -0400
Received: from fmr17.intel.com ([134.134.136.16]:2184 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261862AbVGOVq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 17:46:59 -0400
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Andi Kleen <ak@suse.de>, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Date: Fri, 15 Jul 2005 14:33:45 -0700
User-Agent: KMail/1.5.4
Cc: Chris Friesen <cfriesen@nortel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel> <9a8748490507141906fb7e5b@mail.gmail.com> <20050715020914.GQ23737@wotan.suse.de>
In-Reply-To: <20050715020914.GQ23737@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507151433.46023.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 July 2005 19:09, Andi Kleen wrote:
> > You can't test everything this way, nor should you, but you can test
> > many things, and adding a bit of formal testing to the release
> > procedure wouldn't be a bad thing IMO.
>
> In the linux model that's left to the distributions. In fact doing it
> properly takes months. You wouldn't want to wait months for a new mainline
> kernel.
>
> Formal testing is not really compatible with "release early, release often"
>

This is true.  I think we are seeing the effects of releasing more often than 
we should be into a "stable" tree.  Early and Often make sence for developing 
new features, but should they be pushed into a stable release so often?

> You could do things like "run LTP first", but in practice LTP rarely finds
> bugs.
>
> -Andi

-- 
--mgross
BTW: This may or may not be the opinion of my employer, more likely not.  

