Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTEHHsl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 03:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbTEHHsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 03:48:41 -0400
Received: from slider.rack66.net ([212.3.252.135]:7388 "EHLO slider.rack66.net")
	by vger.kernel.org with ESMTP id S261195AbTEHHsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 03:48:40 -0400
Date: Thu, 8 May 2003 10:01:16 +0200
From: Filip Van Raemdonck <mechanix@debian.org>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J. Bruce Fields" <bfields@fieldses.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: Binary firmware in the kernel - licensing issues.
Message-ID: <20030508080116.GD15296@debian>
Mail-Followup-To: Simon Kelley <simon@thekelleys.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <3EB79ECE.4010709@thekelleys.org.uk> <20030506121954.GO24892@mea-ext.zmailer.org> <20030506151644.GA19898@fieldses.org> <3EB7D7D9.2050603@thekelleys.org.uk> <1052234481.1202.20.camel@dhcp22.swansea.linux.org.uk> <3EB8AD41.5010605@thekelleys.org.uk> <20030507090700.GD25251@debian> <3EB8D7D9.7070304@thekelleys.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB8D7D9.7070304@thekelleys.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 10:54:33AM +0100, Simon Kelley wrote:
> 
> Now Linus could say "I consider that the kernel copyright holders 
> did/didn't give permission to combine  their work with firmware blobs" 
> and I contend that practically all the copyright holders would go along
> with that judgement, just as they went along with Linus's judgement
> about linking binary-only modules with their work.

It's been pointed out repeatedly that there are a few which disagree with
this; they just did not feel compelled (yet?) into action over it.

But there is an important difference in binary modules vs binary
firmware blobs.

In the modules case, it's the binary modules provider which exposes
himself to legal issues.
In the firmware case, you are exposing the kernel itself to IP liability
issues. Do you really want that? (Think SCO)


Regards,

Filip

-- 
"There is a 90% chance that this message was written when the author's been
 up longer than he should have. Please disregard any senseless drivel."
	-- Chris Armstrong
