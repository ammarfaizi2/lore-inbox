Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVCIDR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVCIDR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 22:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVCIDR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 22:17:27 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:38501 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261521AbVCIDR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 22:17:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oW8NJN9+RAXvQxW3vl7mWErnGSQzWqcII86m00VEIvwaRcn4XjkpzAU8wvv93O/BQ5dII5ddqH5IaxtKb9zo1Qz7O6/7O0u3SGYOmPflb2fXjTkwYznhJy67z8sxboIA37kzQrUwwQiN5/JLNlsi9QyWNmLIvRQ5mEU7Kusak3o=
Message-ID: <9e47339105030819172eecc324@mail.gmail.com>
Date: Tue, 8 Mar 2005 22:17:25 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
Cc: xorg@freedesktop.org, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1110326565.32556.7.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1110265919.13607.261.camel@gaston>
	 <1110319304.13594.272.camel@gaston>
	 <9e47339105030815477d0c7688@mail.gmail.com>
	 <1110326565.32556.7.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I do the 'disable all, post, renable last active' sequence in
this scheme?

-- 
Jon Smirl
jonsmirl@gmail.com
