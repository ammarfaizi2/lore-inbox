Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131152AbQKATai>; Wed, 1 Nov 2000 14:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbQKATa2>; Wed, 1 Nov 2000 14:30:28 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:45219 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131152AbQKATaZ>; Wed, 1 Nov 2000 14:30:25 -0500
Message-ID: <3A006EFB.CD2EAF98@linux.com>
Date: Wed, 01 Nov 2000 11:28:59 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <39FFB221.D6A1B5FF@megsinet.net>
Content-Type: multipart/mixed;
 boundary="------------DF397E4DA1CD58344D0715C8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DF397E4DA1CD58344D0715C8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"M.H.VanLeeuwen" wrote:

> 3. Enabling PIIX4, kernel locks hard when printing the partition
>    tables for hdc.   hdc has no partitions.
>    I think this problem is on Ted's problem list???

Disable PIIXn tuning and recompile your kernel.  How does it fare now?

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------DF397E4DA1CD58344D0715C8
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

--------------DF397E4DA1CD58344D0715C8--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
