Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136554AbRAHCUA>; Sun, 7 Jan 2001 21:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136533AbRAHCTu>; Sun, 7 Jan 2001 21:19:50 -0500
Received: from james.kalifornia.com ([208.179.0.2]:50039 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S136503AbRAHCTf>; Sun, 7 Jan 2001 21:19:35 -0500
Message-ID: <3A5923AC.AA6FDA10@linux.com>
Date: Sun, 07 Jan 2001 18:19:24 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <E14FKDI-00033e-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------1051BCC36D66E43A4FDD7826"
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1051BCC36D66E43A4FDD7826
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

> > Um, what about people running their box as just a VLAN router/firewall?
> > That seems to be one of the principle uses so far.  Actually, in that case
> > both VLAN and IP traffic would come through, so it would be a tie if VLAN
> > came first, but non-vlan traffic would suffer worse.
>
> Why would someone filter between vlans when any node on each vlan can happily
> ignore the vlan partitioning

ports 137-139 blather.

-d


--------------1051BCC36D66E43A4FDD7826
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

--------------1051BCC36D66E43A4FDD7826--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
