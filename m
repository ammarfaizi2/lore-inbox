Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280701AbRKBOPb>; Fri, 2 Nov 2001 09:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280700AbRKBOPV>; Fri, 2 Nov 2001 09:15:21 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:12036 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S280699AbRKBOPT>; Fri, 2 Nov 2001 09:15:19 -0500
Date: Fri, 2 Nov 2001 17:14:38 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Tom Vier <tmv5@home.com>, linux-kernel@vger.kernel.org
Subject: Re: alpha tru64 mmap broken in linus kernels
Message-ID: <20011102171438.A699@jurassic.park.msu.ru>
In-Reply-To: <20011101172412.A578@zero> <3BE1CE30.D48D30E7@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BE1CE30.D48D30E7@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 01, 2001 at 05:35:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 05:35:28PM -0500, Jeff Garzik wrote:
> If you need the patch to fix alpha, simply take alan's patch and cut
> away the non-alpha parts.

No, this won't work. Richard Henderson posted the right fix few days
ago with subject "alpha 2.4.13: fix taso osf emulation"; my follow-up
was just an optimization.

Ivan.
