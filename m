Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130075AbQLMKPf>; Wed, 13 Dec 2000 05:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbQLMKP0>; Wed, 13 Dec 2000 05:15:26 -0500
Received: from dhcp07.ncipher.com ([195.224.55.237]:4604 "EHLO passion.cygnus")
	by vger.kernel.org with ESMTP id <S130075AbQLMKPK>;
	Wed, 13 Dec 2000 05:15:10 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0012121719180.20891-100000@www.nondot.org> 
In-Reply-To: <Pine.LNX.4.21.0012121719180.20891-100000@www.nondot.org> 
To: Chris Lattner <sabre@nondot.org>
Cc: "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Dec 2000 09:42:07 +0000
Message-ID: <10532.976700527@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sabre@nondot.org said:
> 1. Boot kernel
> 2. Install corbafs module for example

You misspelled 'codafs' :)

> 3. Start test filesystem in user space
> 4. mount test user space filesystem
> 5. test it, oh crap, it segfaulted.
> 6. CorbaFS gets exceptions trying to communicate to server, which it
> relays to the kernel as -errno conditions.
> 7. You safely unmount corbafs
> 8. fix your bug
> 9. goto step #2.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
