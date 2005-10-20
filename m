Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVJTXqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVJTXqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVJTXqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:46:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932556AbVJTXqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:46:32 -0400
Date: Thu, 20 Oct 2005 16:45:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: xslaby@fi.muni.cz, alexandre.buisse@ens-lyon.fr,
       linux-kernel@vger.kernel.org, jbenc@suse.cz
Subject: Re: Wifi oddness [Was: Re: 2.6.14-rc4-mm1]
Message-Id: <20051020164538.4c30416f.akpm@osdl.org>
In-Reply-To: <43582AA7.4080503@pobox.com>
References: <20051016154108.25735ee3.akpm@osdl.org>
	<20051019184935.E8C0B22AEB2@anxur.fi.muni.cz>
	<20051019184935.E8C0B22AEB2@anxur.fi.muni.cz>
	<20051020210224.B9D4A22AEB2@anxur.fi.muni.cz>
	<43582AA7.4080503@pobox.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Jiri Slaby wrote:
>  > But here is a problem ieee->perfect_rssi and ieee->worst_rssi is 0 and 0, as
>  > you mentioned -- division by zero...
>  > 
>  > It seems, that it is pulled from your tree, Jeff. Any ideas?
>  > 
>  > thanks,
> 
>  When it was pulled?

See the first line of the patch, ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/broken-out/git-netdev-all.patch

it is:

GIT 43e63da3a056da127f2e58b6ce312974b7205ad6 master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git#ALL


