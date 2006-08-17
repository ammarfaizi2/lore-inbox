Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWHQGyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWHQGyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 02:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWHQGyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 02:54:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29140 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932073AbWHQGyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 02:54:18 -0400
Subject: Re: GPL Violation?
From: Arjan van de Ven <arjan@infradead.org>
To: Patrick McFarland <diablod3@gmail.com>
Cc: Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608170242.40969.diablod3@gmail.com>
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
	 <200608170242.40969.diablod3@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 17 Aug 2006 08:54:16 +0200
Message-Id: <1155797656.4494.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 02:42 -0400, Patrick McFarland wrote:
> On Thursday 17 August 2006 01:48, Anonymous User wrote:
> > I work for a company that will be developing an embedded Linux based
> > consumer electronic device.
> >
> > I believe that new kernel modules will be written to support I/O
> > peripherals and perhaps other things.  I don't know the details right
> > now.  What I am trying to do is get an idea of what requirements there
> > are to make the source code available under the GPL.
> 
> I am not a lawyer, and I suggest your company speak with one before doing 
> this. (And most likely, someone from the list will correct me if I get 
> something wrong).
> 
> However, your company only has to release any code they use, preferably in the 
> form of unmodified tarballs (pointing to project websites for downloads isn't 
> valid anymore) plus patches against said unmodified tarballs if modified. If 
> not modified, you still have to release the unmodified tarballs.
> 
> They don't have to release source code for any module you wrote from scratch 
> themselves, but said modules cannot say they are GPL (ie, they have to poison 
> the kernel).

Just as a warning: This is your own legal opinion/advice, one which is
apparently not shared with many other kernel developers, including me.
For example see Greg's OLS keynote:
http://www.kroah.com/log/2006/07/23/#ols_2006_keynote
or some of Linus' emails on this topic:
http://cvs.fedora.redhat.com/viewcvs/*checkout*/rpms/kernel/devel/COPYING.modules?rev=1.5

I hope you have talked to a lawyer about your advice, but I sort of
doubt it since your answer doesn't sound like something a lawyer will
tell you (it sure doesn't match what the various lawyers I talked to
told me, not at all)

Anyway the best advice for anyone who asks such a question is to go talk
to a lawyer, and probably he should take a few of those links printed
out with him just to alert the lawyer about the controversial nature of
things.

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

