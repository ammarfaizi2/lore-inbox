Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131928AbRACAXb>; Tue, 2 Jan 2001 19:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRACAXV>; Tue, 2 Jan 2001 19:23:21 -0500
Received: from james.kalifornia.com ([208.179.0.2]:9534 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131928AbRACAXK>; Tue, 2 Jan 2001 19:23:10 -0500
Message-ID: <3A5269B8.737CA469@linux.com>
Date: Tue, 02 Jan 2001 15:52:24 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: IDE-DMA Timeout Bug may be dead...
In-Reply-To: <Pine.LNX.4.10.10101020847100.25677-100000@master.linux-ide.org>
Content-Type: multipart/mixed;
 boundary="------------C35A539A18001DEE0CD3CD5F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C35A539A18001DEE0CD3CD5F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre Hedrick wrote:

> On Tue, 2 Jan 2001, dep wrote:
>
> > On Tuesday 02 January 2001 06:00 am, Andre Hedrick wrote:
> > | Doing final tests but it may have come to and end and that deadlock
> > | may be gone in a few hours after some sleep.

How 'bout the lockup on boot at partition checking?

-d


--------------C35A539A18001DEE0CD3CD5F
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

--------------C35A539A18001DEE0CD3CD5F--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
