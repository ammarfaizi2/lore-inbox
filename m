Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVHXRzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVHXRzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHXRzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:55:22 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:4882 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751326AbVHXRzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:55:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BPe8+yG62u2rEvTHowyRyZVfEJAZBpMVshjrXkKw7EUv35itoz+iUSEpOXSFDPk0sXI1rNBd0vG+szsBv8YRJo08kU6g7lTPyGLtZ/R0wUg4AwDawHpPQFXLsmX87zw9OvbKEv2fk2Jtyees+9aSg85mi6VKBIuEdd3xBRkZcbc=
Date: Wed, 24 Aug 2005 22:04:17 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Nick Sillik <n.sillik@temple.edu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [-mm PATCH] drivers/char/speakup/synthlist.h - Fix warnings with -Wundef
Message-ID: <20050824180416.GA15819@mipter.zuzino.mipt.ru>
References: <430B8063.8070301@temple.edu> <20050824053703.GA23807@mipter.zuzino.mipt.ru> <430C07F0.8010001@temple.edu> <430C0B33.7000708@temple.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430C0B33.7000708@temple.edu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 01:52:51AM -0400, Nick Sillik wrote:
> --- linux-2.6.13-rc6-mm2/drivers/char/speakup/synthlist.h
> +++ linux-2.6.13-rc6-mm2-patched/drivers/char/speakup/synthlist.h

> -#undef CFG_TEST
> +#undef 

Thou shal test-compile, then send.

Please, be attentive.

