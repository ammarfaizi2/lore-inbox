Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752646AbWKBEhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbWKBEhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 23:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbWKBEhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 23:37:24 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:15083 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1752646AbWKBEhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 23:37:23 -0500
Date: Wed, 1 Nov 2006 20:37:22 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: [CRYPTO] Use aes hardware crypto device from userspace [Try #2]
In-Reply-To: <20061031091126.37294.qmail@web23106.mail.ird.yahoo.com>
Message-ID: <Pine.LNX.4.64.0611012035540.20059@twinlark.arctic.org>
References: <20061031091126.37294.qmail@web23106.mail.ird.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006, moreau francis wrote:

> Hello,
> 
> I need to make AES ciphering in a userspace application. My platform
> has an integrated crypto engine which is used by the kernel through
> the core cryptographic API.
> 
> Is it possible to export easily this hardware to userspace just by writing
> a dumb driver that would rely on the core crypto API ?  Are there any
> races issues ?

perhaps this is of interest:

http://ocf-linux.sourceforge.net/

-dean
