Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131875AbQKAXjD>; Wed, 1 Nov 2000 18:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131912AbQKAXix>; Wed, 1 Nov 2000 18:38:53 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:20485 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S131911AbQKAXis>;
	Wed, 1 Nov 2000 18:38:48 -0500
Date: Wed, 1 Nov 2000 16:37:52 -0700
From: Nathan Paul Simons <npsimons@fsmlabs.com>
To: "David S. Miller" <davem@redhat.com>
Cc: garloff@suse.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001101163752.B2616@fsmlabs.com>
Reply-To: npsimons@fsmlabs.com
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <200011012247.OAA19546@pizda.ninka.net>; from David S. Miller on Wed, Nov 01, 2000 at 02:47:21PM -0800
X-Bad-Disk-Header: Do you ever get that syncing feeling?
Organization: FSMLabs <http://www.fsmlabs.com/>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 02:47:21PM -0800, David S. Miller wrote:
>    kgcc is a redhat'ism.
> 
> Debian has it too.

        Debian doesn't have a kgcc, it's a gcc272, which is described as
follows:

"This is the old version of the GNU C compiler's C part. It should only be
used for backward compatibility purposes."

        i don't have the gcc272 package installed under Debian, and i use the
standard compiler that comes with Debian (2.95.2) and it works fine on Intel
and Alpha for compiling 2.4 and 2.2, so there :P

<rant mode="flame">
	This whole stupid 'kgcc' thing is yet another in a long line of really
dumb things that RedHat has done and it's just another reason i'm glad i
switched from RedHat to Debian.
<rant mode="off">

-- 
Nathan Paul Simons, Junior Software Engineer for FSMLabs
http://www.fsmlabs.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
