Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSFTG3i>; Thu, 20 Jun 2002 02:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSFTG3i>; Thu, 20 Jun 2002 02:29:38 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25456 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318130AbSFTG3h>; Thu, 20 Jun 2002 02:29:37 -0400
Date: Thu, 20 Jun 2002 08:30:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020620063049.GA10718@dualathlon.random>
References: <20020620055933.GA1308@dualathlon.random> <20020619.230454.111974636.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020619.230454.111974636.davem@redhat.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 11:04:54PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Thu, 20 Jun 2002 07:59:33 +0200
> 
>    Also not yet sure if DaveM is ok with the removal of
>    prepare_to_switch, his last comment on that is negative as far I
>    could see.
> 
> Ingo's stuff is perfectly fine, it was a brain fart
> wrt. prepare_to_switch.

Ok, thanks for the info. prepare_arch_switch looked in the same place,
but just in case. :)

Andrea
