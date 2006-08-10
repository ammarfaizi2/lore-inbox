Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWHJUTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWHJUTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWHJUT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:19:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932098AbWHJUSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:18:49 -0400
Date: Thu, 10 Aug 2006 13:18:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Robert Love" <rlove@rlove.org>
Cc: "Shem Multinymous" <multinymous@gmail.com>, linux-kernel@vger.kernel.org,
       "Pavel Machek" <pavel@suse.cz>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/12] ThinkPad embedded controller and hdaps drivers
 (version 2)
Message-Id: <20060810131820.23f00680.akpm@osdl.org>
In-Reply-To: <acdcfe7e0608100646s411f57ccse54db9fe3cfde3fb@mail.gmail.com>
References: <1155203330179-git-send-email-multinymous@gmail.com>
	<acdcfe7e0608100646s411f57ccse54db9fe3cfde3fb@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 09:46:47 -0400
"Robert Love" <rlove@rlove.org> wrote:

> Patches look great and I am glad someone has apparently better access
> to hardware specs than I did.

This situation is still a concern.  From where did this additional register
information come?

Was it reverse-engineered?  If so, by whom and how can we satisfy ourselves
of this?

Was it from published documents?

Was it improperly obtained from NDA'ed documentation?

Presumably the answer to the third question will be "no", but if
challenged, how can we defend this assertion?

So hm.  We're setting precedent here and we need Linus around to resolve
this.  Perhaps we can ask "Shem" to reveal his true identity to Linus (and
maybe me) privately and then we proceed on that basis.  The rule could be
"each of the Signed-off-by:ers should know the identity of the others".
