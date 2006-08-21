Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWHUAh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWHUAh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWHUAh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:37:27 -0400
Received: from mother.openwall.net ([195.42.179.200]:35280 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S932366AbWHUAhY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:37:24 -0400
Date: Mon, 21 Aug 2006 04:33:21 +0400
From: Solar Designer <solar@openwall.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce CONFIG_BINFMT_ELF_AOUT
Message-ID: <20060821003321.GA22541@openwall.com>
References: <20060819232556.GA16617@openwall.com> <20060821001628.GC2861@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821001628.GC2861@dmt>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 09:16:29PM -0300, Marcelo Tosatti wrote:
> I dislike this change.

Which one?  The introduction of CONFIG_BINFMT_ELF_AOUT or having it and
CONFIG_BINFMT_AOUT disabled by default - or both?

> We had this discussion before, didnt we?

Yes, you had proposed the same thing that Willy did - to introduce
CONFIG_BINFMT_ELF_AOUT but have it default to enabled, and to not
change any other defaults.  I simply haven't had the time (nor
motivation since this almost defeats the purpose of the patch) to
re-arrange the patch for that yet, so I decided to post what I readily
had first for public comment.  I should have mentioned this past
discussion in my posting, sorry.

Thanks,

Alexander
