Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbUKGW11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbUKGW11 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 17:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUKGW10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 17:27:26 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:47543 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261695AbUKGW1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 17:27:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YuVms6fLV9EO0TddH6ksb7yVC1ATx8ygpDXFUFq8WQX5ykcABx6oPFX22b8awl+RLtDXQ9Vj3agY/58v2vwUebVyeVwEWkhkLk6lNNNg7FSJEYSqV9S6TtSKko18HvQtuALjnZeHCKIvyaQzKRQtVVPw4SZ25ivmmf7FjK/AjSU=
Message-ID: <21d7e99704110714276228ff9b@mail.gmail.com>
Date: Mon, 8 Nov 2004 09:27:23 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: John McGowan <jmcgowan@inch.com>
Subject: Re: (non) "bug" in 810 (kernel 2.6.9)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041106212327.GA3592@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041106212327.GA3592@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had reported a problem with getting a working screen in X with kernel
> 2.6.9. It is not a bug, but a change.
> 

I can't reproduce this on my system at all, I've got an i815 (slightly
newer chipset than i810 - maybe something in that...) but I've just
compiled a kernel with the i810 drm built in and started X in 24-bit
color on 2.6.9 without incident...

I'm running Xorg 6.8.0-rc3.... its wierd I've no idea what could be
causing it ...

Dave.
