Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVAEMGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVAEMGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 07:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVAEMGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 07:06:06 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:47846 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262350AbVAEMGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 07:06:02 -0500
Date: Wed, 5 Jan 2005 13:06:02 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ast@domdv.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, joq@io.com
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050105120601.GA8730@mail.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, ast@domdv.de,
	rlrevell@joe-job.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
	joq@io.com
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de> <1104898693.24187.162.camel@localhost.localdomain> <20050104215010.7f32590e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104215010.7f32590e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 09:50:10PM -0800, Andrew Morton wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> >  Can we use capabilities
> 
> capabilities don't work :(
> 
> 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.0/0502.html

well, maybe it is time to fix them ..

I already proposed some methods to extend them,
and I'm also willing to dig into the various things
required to allow to use the capability system for
what it was intended.

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
