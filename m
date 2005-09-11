Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVIKWtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVIKWtn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVIKWtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:49:43 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:28699 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750990AbVIKWtm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:49:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tk3psom7I6neCWYQGuEgOxAIWy65Us09xzkQtvCcElySwpy7Y/s66ECxsBdH3+prdw+5yiYYIOK4uazuUBM7NlVCwxnV7fKnaPvUkCKEGsr04Fws6fVOvIipdJoI5MCVVTAeHkGgtWFDf7OIiNIEB5JZbYHLsBhxrr3LqqBe1WI=
Message-ID: <81b0412b050911154931d87ca9@mail.gmail.com>
Date: Mon, 12 Sep 2005 00:49:33 +0200
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: raa.lkml@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Cc: Linus Torvalds <torvalds@osdl.org>, petero2@telia.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050911151240.478006e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m3mzmjvbh7.fsf@telia.com>
	 <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
	 <20050911151240.478006e0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Andrew Morton <akpm@osdl.org> wrote:
> > Does anyone else see this? "host www.kernel.org" gives me two IP
> > addresses:
> >
> >          www.kernel.org is an alias for zeus-pub.kernel.org.
> >          zeus-pub.kernel.org has address 204.152.191.5
> >          zeus-pub.kernel.org has address 204.152.191.37
> >
> > Is it possible that one of those computers hasn't received the latest
> > changes for some reason?
> 
> Yes, I'd say that's the problem.

Could this be reason I'm getting this from cogito trying to update git:

Applying changes...
error: unable to find 720d150c48fc35fca13c6dfb3c76d60e4ee83b87
fatal: git-cat-file 720d150c48fc35fca13c6dfb3c76d60e4ee83b87: bad file
usage: git-cat-file [-t | -s | <type>] <sha1>
Invalid commit id: 720d150c48fc35fca13c6dfb3c76d60e4ee83b87
