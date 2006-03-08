Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWCHT1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWCHT1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWCHT1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:27:30 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:37856 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030190AbWCHT1Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:27:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V6KInoIZCEuaIKIZREX4K11U9W4ulIYxMWhd8JZmr6rCd0TJMetLa5+tBRPaBi+x4NIcN1ouGfMfhp2bhHraa8N0kWURegw0hMpaWq3ogSQq7U1EcJrrv9MwQN5JItnk/R+ZdNJeZxHylFUR7TaiAF86hvRkYICzbweFfB2LjwY=
Message-ID: <9a8748490603081127r1b830c5bg94f42e021e2a2d58@mail.gmail.com>
Date: Wed, 8 Mar 2006 20:27:24 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [Updated]: How to become a kernel driver maintainer
Cc: "Ben Collins" <bcollins@ubuntu.com>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <1141845047.12175.7.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1136736455.24378.3.camel@grayson>
	 <1136756756.1043.20.camel@grayson>
	 <1136792769.2936.13.camel@laptopd505.fenrus.org>
	 <1136813649.1043.30.camel@grayson>
	 <1136842100.2936.34.camel@laptopd505.fenrus.org>
	 <1141841013.24202.194.camel@grayson>
	 <9a8748490603081105i3468fa84haac329d1e50faed4@mail.gmail.com>
	 <1141845047.12175.7.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > > about the change to start discussion.
> > >
> > Perhaps add a bit of text here about integrating patches send to you,
> > as maintainer of the driver, by random people.
>
> it's not integrating.
> It's reviewing and passing on for merge ;)
> fundamental difference. You don't "own" the driver in the tree. You just
> keep it nice and shiny and clean. Best done by blessing patches, and by
> developing in "patches" not "new codebase". The entire "new codebase"
> thinking is the problem with CVS-think. Think in patches (once merged),
> not in code/tree.
>

Yeah, right, that's basically what I meant even if it's not what I
actually said.
I just wanted to say that it should be described that you also have a
responsability as maintainer for working with other people, review
their patches, sign off on them, make sure they get picked up and
forwarded to the proper people etc etc.

Thank you for making it more clear.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
