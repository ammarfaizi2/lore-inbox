Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129435AbQKBC6d>; Wed, 1 Nov 2000 21:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbQKBC6X>; Wed, 1 Nov 2000 21:58:23 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:62372 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129435AbQKBC6H>; Wed, 1 Nov 2000 21:58:07 -0500
Message-ID: <3A00D82F.618D3534@linux.com>
Date: Wed, 01 Nov 2000 18:57:52 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <39FFB221.D6A1B5FF@megsinet.net> <3A006EFB.CD2EAF98@linux.com> <3A00B08A.13A971C0@megsinet.net>
Content-Type: multipart/mixed;
 boundary="------------DF3475752AFE55904C101B38"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DF3475752AFE55904C101B38
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Yes..long standing bug, and I don't have sufficient time to get my feet wet in the IDE dept
and fix it.

-d

"M.H.VanLeeuwen" wrote:

> > Disable PIIXn tuning and recompile your kernel.  How does it fare now?
>
> Yep, disabling (opposite of "enabling") does allow the kernel to boot just fine.
> PIIXn tuning must be tickling something on the system so that the first time we
> read from the disk, partition check block 0, the system freezes hard.

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------DF3475752AFE55904C101B38
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
org:<img src="http://www.kalifornia.com/images/paradise.jpg">
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;-12480
fn:David Ford
end:vcard

--------------DF3475752AFE55904C101B38--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
