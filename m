Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbRAaFYo>; Wed, 31 Jan 2001 00:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130582AbRAaFYf>; Wed, 31 Jan 2001 00:24:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1931 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129745AbRAaFYV>;
	Wed, 31 Jan 2001 00:24:21 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14967.41278.556719.597986@pizda.ninka.net>
Date: Tue, 30 Jan 2001 21:23:10 -0800 (PST)
To: Rusty Russell <rusty@linuxcare.com.au>
Cc: Javier Miguel Rodríguez (GUFO) 
	<javier.miguel@futurainteractiva.com>,
        linux-kernel@vger.kernel.org, netfilter@us5.samba.org
Subject: Re: 2.4.0+ipchains+sparc 450= CRASH! 
In-Reply-To: <E14NoTY-0007lF-00@halfway>
In-Reply-To: <01013014063301.15042@Petete>
	<E14NoTY-0007lF-00@halfway>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty Russell writes:
 > Oops.  Thanks to Anton for testing and touching up this patch.
 > 
 > The 2.0/2.2 setsockopt code used to do the copy_from_user for you...

I've applied this to my tree, thanks a lot.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
