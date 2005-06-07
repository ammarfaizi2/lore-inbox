Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVFGIT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVFGIT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 04:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVFGIT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 04:19:58 -0400
Received: from mail.gmx.de ([213.165.64.20]:10726 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261764AbVFGIT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 04:19:57 -0400
X-Authenticated: #428038
Date: Tue, 7 Jun 2005 10:19:54 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Voluspa <lista1@telia.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050607081954.GA13892@merlin.emma.line.org>
Mail-Followup-To: Voluspa <lista1@telia.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, ak@suse.de
References: <20050607081116.65c10190.lista1@telia.com> <20050607061831.GA6957@elte.hu> <20050607083731.5edfd276.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607083731.5edfd276.lista1@telia.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jun 2005, Voluspa wrote:

> Ah, sorry about the noise... I've been away from kernel testing too
> long. I patched a 2.6.11.11 tree without noticing all the rejects (this
> new machine is fast). But from what I remember, it was decided to do
> the -rc patches against the latest stable codebase, in this case .11
> Shrug.

Try adding "-s" to the patch command then.

-- 
Matthias Andree
