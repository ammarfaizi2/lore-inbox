Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264731AbUEJOtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbUEJOtf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbUEJOtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:49:35 -0400
Received: from imap.gmx.net ([213.165.64.20]:50626 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264731AbUEJOtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:49:03 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Subject: Re: 2.6.6-mm1
Date: Mon, 10 May 2004 16:55:52 +0200
User-Agent: KMail/1.6.2
References: <20040510024506.1a9023b6.akpm@osdl.org> <200405101138.04094.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200405101138.04094.norberto+linux-kernel@bensa.ath.cx>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405101655.52497.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reverted this patch too, but it works without problems here.

greets dominik

On Monday 10 May 2004 16:38, you wrote:
> Andrew Morton wrote:
> > make-4k-stacks-permanent.patch
> >   make 4k stacks permanent
>
> I've reverted this one (nvidia crash blah blah...) but I still can't get a
> working system. The box just sits there doing -apparently- nothing.
>
> Which other patch{,es} am I missing?
>
> Best regards,
> Norberto
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
