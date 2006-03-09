Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWCIVPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWCIVPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbWCIVPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:15:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:31502 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751617AbWCIVPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:15:38 -0500
Date: Thu, 9 Mar 2006 22:15:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, rolandd@cisco.com, gregkh@suse.de,
       akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 18 of 20] ipath - kbuild infrastructure
Message-ID: <20060309211502.GA24460@mars.ravnborg.org>
References: <ac5354bb50d515de2a5c.1141922831@localhost.localdomain> <ada4q27ld33.fsf@cisco.com> <20060309185604.GA24004@mars.ravnborg.org> <adafylrigug.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adafylrigug.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 11:00:07AM -0800, Roland Dreier wrote:
>     Sam> Eventually - yes.  But not just now. Kbuild was introduced
>     Sam> because it was needed in the top-level directory and it made
>     Sam> good sense to do so.  But for now keeping Makefile is a good
>     Sam> choice. This is anyway what people are used to.
> 
> OK, disregard my suggestion then.  Should we patch
> Documentation/kbuild/makefiles.txt to correct the current
> documentation, which says:
> 
>   The preferred name for the kbuild files is 'Kbuild' but 'Makefile'
>   will continue to be supported. All new developmen is expected to use
>   the Kbuild filename.
> 
Yes - I will do so. Thanks.

	Sam
