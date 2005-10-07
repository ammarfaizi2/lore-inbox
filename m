Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVJGIP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVJGIP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 04:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVJGIP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 04:15:56 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:4955 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932113AbVJGIPz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 04:15:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Od/BPxQA/NosxCNIiiRxwad9NlgMidYQJcdPhm4BCy5cmKduW0tUsA1bwev9Bg2VkwlYnekAnr7v7qTJVqtKCcC7XvxFDbelG3Q+qXvtsfcApuo89nP2W19VbB24/IbgOOZp4AUItS975T7ftrG29gyHfikcbG1eqq0jZqjVqRM=
Date: Fri, 7 Oct 2005 10:15:38 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Ian McDonald <imcdnzl@gmail.com>
Cc: greg@kroah.com, shemminger@osdl.org, netdev@vger.kernel.org,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       riel@surriel.com
Subject: Re: [ANNOUNCE] linux-net wiki
Message-Id: <20051007101538.7778bd1a.diegocg@gmail.com>
In-Reply-To: <cbec11ac0510061834j53678e7cq@mail.gmail.com>
References: <20051006140007.43262f04@dxpl.pdx.osdl.net>
	<20051007012454.GA9509@kroah.com>
	<cbec11ac0510061834j53678e7cq@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 7 Oct 2005 14:34:10 +1300,
Ian McDonald <imcdnzl@gmail.com> escribió:

> >
> > Why not just work with the existing kernelnewbies wiki:
> >         http://wiki.kernelnewbies.org
> > instead of creating another site?
> >
> Having a quick look around and looking at the name in particular I
> think they are different target audiences...

The fact that it's called "kernelnewbies" doesn't meant it's targetted only
to non-expert people - everybody, including me, you, Linus and all the "core"
kernel hackers are "newbies" WRT to some parts of the kernel. The one thing
that can keep someone being a newbie forever is considering himself an
"expert". In fact you can find some linux kernel "gurus" there...

Also, kernelnewbies is not linux-specific either so there's a chance that even
gurus could learn something interesting (and teach something to others). 
Or at least that has always been the intention of the kernelnewbies project.

(That doesn't mean I'm against the linux-net wiki, I just wanted to point out
that kernelnewbies isn't just for "newbies" ;)
