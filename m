Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293696AbSCFRKE>; Wed, 6 Mar 2002 12:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293681AbSCFRJy>; Wed, 6 Mar 2002 12:09:54 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:45532 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293696AbSCFRJY>;
	Wed, 6 Mar 2002 12:09:24 -0500
Date: Wed, 6 Mar 2002 09:09:22 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre2]
Message-ID: <20020306090922.A2159@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020305163840.B1525@bougret.hpl.hp.com> <3C85A1BA.512E0324@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C85A1BA.512E0324@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Mar 05, 2002 at 11:57:30PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 11:57:30PM -0500, Jeff Garzik wrote:
> We don't need the silly spinlock wrappers in 2.4 either.....

	I don't have the patch to un-wrap the spinlock. I think you
have that in your archives. Just send that to Marcelo on top of my
patch.
	As usual, I don't really care about cosmetics ;-)

	Jean
