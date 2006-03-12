Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWCLBvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWCLBvm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 20:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWCLBvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 20:51:42 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:8619 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751454AbWCLBvl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 20:51:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hQCoSTK1KtAEnJ6rp1w5lSHV/BCNV227UpWHC8VwnFMCBh61XZ9Ww8SwWx//hyHnS0IXIMo0mPT9VUdbjkKcvJChbx2ytkqiWbk2QwLgDlUGAR09ARIif/EhSeax8jzspueYsd0ADEhL5OB02SCMBnGOmT5zD5ATn/Gx2tqkbR8=
Message-ID: <6bffcb0e0603111751i1ed30794s@mail.gmail.com>
Date: Sun, 12 Mar 2006 02:51:40 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Linux v2.6.16-rc6
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/03/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> Ok, we're getting closer, although the 2.6.16 release certainly seems to
> drag out more than it should have.
>

I have noticed this warnings
TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
148470938:148470943. Repaired.
TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
148470938:148470943. Repaired.
TCP: Treason uncloaked! Peer 82.113.55.2:11759/59768 shrinks window
1124211698:1124211703. Repaired.
TCP: Treason uncloaked! Peer 82.113.55.2:11759/59768 shrinks window
1124211698:1124211703. Repaired.

It maybe problem with ktorrent.

Here is config http://www.stardust.webpages.pl/files/linux/2.6.16-rc6/config
Here is dmesg http://www.stardust.webpages.pl/files/linux/2.6.16-rc6/dmesg

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
