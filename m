Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVAJQyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVAJQyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVAJQw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:52:28 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19176 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262335AbVAJQvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:51:43 -0500
Message-Id: <200501101650.j0AGoP5t030855@laptop11.inf.utfsm.cl>
To: Adam Sampson <azz@us-lot.org>
cc: L A Walsh <lkml@tlinx.org>, linux-kernel@vger.kernel.org
Subject: Re: Reviving the concept of a stable series 
In-Reply-To: Message from Adam Sampson <azz@us-lot.org> 
   of "Mon, 10 Jan 2005 13:44:08 -0000." <y2ais65z9ef.fsf@cartman.at.fivegeeks.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 10 Jan 2005 13:50:25 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 10 Jan 2005 13:50:29 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Sampson <azz@us-lot.org> said:
> L A Walsh <lkml@tlinx.org> writes:
> > If you have a better way of creating a stable series of kernels
> > coming off kernel.org, I'm not attached to any specific method of
> > "how".

> One option would be a "Linux Legacy" project, similar to the Fedora
> Legacy project that backports updates to old Red Hat/Fedora Core
> releases: a central service that'd collect bug fixes for released
> kernels that distributors could then base their kernels on. That way,
> we'd get the stability advantages of vendor kernels without needing to
> repeat the effort for each distribution.

Didn't happen with 2.0, 2.2, or 2.4. I'd guess it won't happen for 2.6
either.

> Maybe some of the distribution vendors might be interested in setting
> up something like this?

I have seen absolutely no interest from distributions in leaving the
current 2.6 development model.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
