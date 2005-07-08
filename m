Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVGHTil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVGHTil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVGHTft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:35:49 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:5304 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262810AbVGHTeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:34:13 -0400
Subject: Re: share/private/slave a subtree - define vs enum
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Bryan Henderson <hbryan@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.61.0507082108530.3728@scrub.home>
References: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
	 <courier.42CEC422.00001C6C@courier.cs.helsinki.fi>
	 <Pine.LNX.4.61.0507082108530.3728@scrub.home>
Date: Fri, 08 Jul 2005 22:33:41 +0300
Message-Id: <1120851221.9655.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-07-08 at 21:11 +0200, Roman Zippel wrote:
> So it basically comes down to personal preference, if the original uses 
> defines and it works fine, I don't really see a good enough reason to 
> change it to enums, so please leave the decision to author.

(And I don't see a good enough reason to use #defines when you don't
 absolutely have to. This is what we disagree on.)

Roman, it is not as if I get to decide for the patch submitters. I
comment on any issues _I_ have with the patch and the authors fix
whatever they want (or what the maintainers ask for).

As I disagree with the part about enums being a personal preference, I
will continue to comment on them in the future. If patch authors wish to
ignore them (or any of my comments for that matter), that's ok with me.

P.S. Working code is not enough for the kernel. It must be maintainable
as well.

			Pekka

