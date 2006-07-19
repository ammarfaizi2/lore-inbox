Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWGSLD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWGSLD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 07:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWGSLD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 07:03:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:5165 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964795AbWGSLD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 07:03:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bCEYFTenR9T1iwFt8KdBczyjBES+SiUax6uTzxqNxB4GiaMYY/we3gPunia9G1QjEEVfMnArrBL0ZYLpQFzP9SwBE0mm/6bS/NQlPWmLMhxR5YtsAXO1RF1QuiTlrOaaAo423cdiayxb7cQBchCxgyuzyTcEth0Q4ZLMpRQLmS8=
Message-ID: <84144f020607190403y1a659c99oc795ae244390c2ee@mail.gmail.com>
Date: Wed, 19 Jul 2006 14:03:54 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Tilman Schmidt" <tilman@imap.cc>
Subject: Re: Reiser4 Inclusion
Cc: linux-kernel@vger.kernel.org, "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Matthias Andree" <matthias.andree@gmx.de>,
       "Grzegorz Kulewski" <kangur@polcom.net>,
       "Diego Calleja" <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com
In-Reply-To: <fake-message-id-1@fake-server.fake-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BAFDB7.9050203@calebgray.com>
	 <1153128374.3062.10.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net>
	 <20060717160618.013ea282.diegocg@gmail.com>
	 <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net>
	 <20060717155151.GD8276@merlin.emma.line.org>
	 <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr>
	 <20060718204718.GD18909@merlin.emma.line.org>
	 <fake-message-id-1@fake-server.fake-domain>
X-Google-Sender-Auth: 8d0a69e86cf67eaf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/06, Tilman Schmidt <tilman@imap.cc> wrote:
> You can't have it both ways. Either you want everything in the main
> kernel tree or you don't. Of course there will always be a limbo of
> code waiting for inclusion. But if it has to linger there for too
> long (again: no matter for what reason) then it invalidates the
> whole concept of not having a stable API. And that would be a pity.

You seem to have this idea of everyone having some sacred right of
having their code either in the kernel or supported by the kernel
developers. That's fine, but last I checked, does not apply to Linux.
It is up to the maintainers to decide what's included and what's not.
We obviously don't want _everything_ in the kernel anyway and don't
want to stagnate the kernel development because of out-of-tree code
either. If you're unhappy about maintainer decisions, feel free to
complain to them or better yet, step up to do the necessary legwork to
get the code included. After all, that's how Linux development works.
