Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVH0Pg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVH0Pg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 11:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVH0Pg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 11:36:59 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:63543 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751220AbVH0Pg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 11:36:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bZRIAMg/JK8RoDqJt+Mu6znFx2ixZC5Yc6Hb6G+fXUQJVJGGctvwdSaUcwL8pS3PrUMfRvLTbPFWABo04hqHOn09+DB7q6RYTRUSknQuj9uVF/VxwqW5GNuA7/G1JyU9m6tDu2HDlvXZKrBsmRuUg4rQADH3YALH7iToH6//fYw=
Date: Sat, 27 Aug 2005 19:46:14 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Asus a8v-e Deluxe lockups
Message-ID: <20050827154614.GA7407@mipter.zuzino.mipt.ru>
References: <20050825214855.GA4434@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825214855.GA4434@the-penguin.otak.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 02:48:55PM -0700, Lawrence Walton wrote:
>  I just switched out motherboards and CPUs From a Asus K8v SE Deluxe
> to a to a Asus A8V-E Deluxe, and a 754 pin 3200+ to a 934 pin 3200+.
> I am now having some fairly serious instability issues.

I've filed a bug at kernel bugzilla so your report won't be lost. See
http://bugme.osdl.org/show_bug.cgi?id=5139

Please, register at http://bugme.osdl.org/createaccount.cgi and add
yourself to CC list.

Martin J. Bligh set up a webpage describing basic kernel hangs
debugging: http://mbligh.org/linuxdocs/kernel/hang.html

