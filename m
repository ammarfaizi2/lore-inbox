Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTJVLFL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTJVLFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:05:10 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:37283 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263510AbTJVLFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:05:06 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 22 Oct 2003 13:02:44 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test8 oops (ipv6 related?)
Message-ID: <20031022110244.GA30227@bytesex.org>
References: <20031022091300.GA27824@bytesex.org> <20031022033112.4d8323e4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031022033112.4d8323e4.davem@redhat.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 03:31:12AM -0700, David S. Miller wrote:
> On Wed, 22 Oct 2003 11:13:00 +0200
> Gerd Knorr <kraxel@bytesex.org> wrote:
> 
> > This is what I got on the serial console:
> > 
> > Unable to handle kernel paging request at 000000ff00388090 RIP:
> > <ffffffff801a0042>{__memcpy+114}PML4 0
> 
> Hmmm, what platform?  I suspect something funny wrt. to this
> platform rather than ipv6 as this particular code path is well
> tested.

It is a x86_64 machine.

  Gerd

-- 
You have a new virus in /var/mail/kraxel
