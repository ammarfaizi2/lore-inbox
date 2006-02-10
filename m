Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWBJWGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWBJWGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWBJWGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:06:45 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:44918 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750747AbWBJWGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:06:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=X7B36N0UDapbwtlplcjUDT+8FnLOny4RFqMejSIq6ZSYUpH83ypz5acUxV+Z7StH2Y5aEpLLvIcsMPEM3CJojR99P/8ubZe5HXxBqnzDoU3giu2a41tH6fztOzIVH4/zCIDxxLpYukS2TTSV0kZcjJCUdzHttfNz1K1XMGICyrI=
Date: Sat, 11 Feb 2006 01:25:15 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Marc Koschewski <marc@osknowledge.org>
Cc: Linux-LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [BUG GIT] Unable to handle kernel paging request at virtual address e1380288
Message-ID: <20060210222515.GA4793@mipter.zuzino.mipt.ru>
References: <20060210214122.GA13881@stiffy.osknowledge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210214122.GA13881@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 10:41:22PM +0100, Marc Koschewski wrote:
> I just wanted to mount an external USB HDD... this was what I got:

> [4297455.819000] EIP:    0060:[<c01ee88e>]    Tainted: P      VLI

Kindly reproduce without proprietary modules loaded.

