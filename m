Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129539AbQL2IpX>; Fri, 29 Dec 2000 03:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbQL2IpO>; Fri, 29 Dec 2000 03:45:14 -0500
Received: from james.kalifornia.com ([208.179.68.97]:24131 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129539AbQL2IpC>; Fri, 29 Dec 2000 03:45:02 -0500
Message-ID: <3A4C47DF.B1541832@linux.com>
Date: Fri, 29 Dec 2000 00:14:24 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mike@kre8tive.org
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Repeatable 2.4.0-test13-pre4 nfsd Oops rears it head again
In-Reply-To: <20001228161126.A982@lingas.basement.bogus> <200012282159.NAA00929@pizda.ninka.net> <20001228212116.A968@lingas.basement.bogus>
Content-Type: multipart/mixed;
 boundary="------------B6C843C595D20CEA0A62C8D7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B6C843C595D20CEA0A62C8D7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> I really need to get rid of this 8139 card.  Since
> yall are the oracle, which nice 100mbs card is fine
> hardware and is coupled with a well debugged driver?
>
> I don't want to have any more network card problems.
> I'm tired of this crappy 8139.

I have an 8139 card and it's on a 2.4 testN kernel that's several weeks old but
it's running like a champ at 200FD, sometimes heavily loaded.

-d


--------------B6C843C595D20CEA0A62C8D7
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------B6C843C595D20CEA0A62C8D7--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
