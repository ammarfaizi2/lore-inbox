Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLNABE>; Wed, 13 Dec 2000 19:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbQLNAAy>; Wed, 13 Dec 2000 19:00:54 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:42629 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129423AbQLNAAm>; Wed, 13 Dec 2000 19:00:42 -0500
Date: Wed, 13 Dec 2000 23:30:15 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0-test12:
Message-ID: <20001213233015.Q5918@redhat.com>
In-Reply-To: <20001213192352.L5918@redhat.com> <20001213231155.A2690@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001213231155.A2690@gruyere.muc.suse.de>; from ak@suse.de on Wed, Dec 13, 2000 at 11:11:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 11:11:55PM +0100, Andi Kleen wrote:

> Perhaps it should mention that the guaranteed useful range of atomic_t 
> is only 24bit ?  Documentation without source would rather useless if it
> didn't mention such pitfalls.

Does
<URL:ftp://people.redhat.com/twaugh/patches/linux24/linux-macrodoc.patch>
look better?

Tim.
*/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
