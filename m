Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVKFK7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVKFK7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 05:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVKFK7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 05:59:36 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:20769 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932354AbVKFK7g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 05:59:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qMHt4y+VrY2NRmGXh3Gt8NmoxpdaV0HW4Iw1k5/2T1L6USUeFF7EJDoyTxv6UgrJ2blG46C35yoKgEwXxM+3v8FNEwEaR32YGJCn83KnkvclcFLNzz37N4sVE2DICbdVJ7rggb1xJ/qNf8oosgJovxsEQwAQRwSdtXGGv3iDclI=
Message-ID: <35fb2e590511060259j69b792baofee9b9d842c53c07@mail.gmail.com>
Date: Sun, 6 Nov 2005 10:59:34 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATCH: fix-readonly-policy-use-and-floppy-ro-rw-status
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051105184122.GA30451@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051105182728.GB27767@apogee.jonmasters.org>
	 <20051105184122.GA30451@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/05, Jeff Garzik <jgarzik@pobox.com> wrote:

> Please fix your patch format per http://linux.yyz.us/patch-format.html

Done.

> - Using "[PATCH] " not "PATCH: " in subject line.

That was already the case. I repeated the word PATCH in the body too however.

> - Don't repeat "[PATCH]" in text body, this must be manually edited out.

Ok. Fair enough.

> - This is English, not dashish.  Remove the dashes from the
>   one-line description found in the subject line.  These must be
>   hand-edited out, too.

I read that as Danish the first time :-) But then realised this was
because I'd based it off something I'd sent to Andrew last week. Fair
comment.

Jon.
