Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUJEUCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUJEUCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUJETyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:54:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11720 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265127AbUJETwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:52:23 -0400
Message-ID: <4162FB6E.2080103@redhat.com>
Date: Tue, 05 Oct 2004 15:52:14 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Arjan van de Ven <arjanv@redhat.com>,
       "Johnson, Richard" <rjohnson@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.5-1.358 and Fedora
References: <1097004565.9975.25.camel@laptop.fenrus.com> <Pine.LNX.4.61.0410052140150.2913@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0410052140150.2913@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
<snip>
> While I lack specific Fedora knowledge and thus can't provide exact 
> details for it I'd say it should still be pretty simple to recover. On 
> Slackware I'd simply boot a kernel from the install CD and tell it to 
> mount the installed system on my HD, then you'll have a running system and 
> can easily clean out the broken modules etc and install the original ones 
> from your CD and be right back where you started in 5 min. Surely 
> something similar is possible with Fedora, reinstalling from scratch (as 
> he said he did) seems like massive overkill to me.
> 
> 
If all you're after is a resuce cd, you can use the fedora CD's for that 
by typing:
linux rescue
at the boot prompt.  Your root fs will be mounted under /mnt/sysimage, 
and you can go in from a shell, and clean up anything you like.

Neil
> --
> Jesper Juhl
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
