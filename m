Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVKBAoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVKBAoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVKBAoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:44:18 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:15879 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932099AbVKBAoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:44:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=tbyVy3yp1Fd4cBSTX5K3WEeZwNkAvbZJoBOmpGdAIEbVKSNNwRCFI32+4sykeRq/YIVaNzTUBplhj248H+Kd8taDOrEefRn5y/3BoUOAsThw+FyvQbFoJ3CrktjIp60xj4t2JETfiZkt5QRr2+cRSmj9emrILIYVxZ2rdfShf38=
Message-ID: <43680BDA.7050308@pol.net>
Date: Wed, 02 Nov 2005 08:44:10 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/video/vgastate.c: kill dead code
References: <20051101205406.GA8009@stusta.de>
In-Reply-To: <20051101205406.GA8009@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch kills some dead code.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked by: Antonino Daplas <adaplas@pol.net>
