Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRAAAmh>; Sun, 31 Dec 2000 19:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbRAAAm2>; Sun, 31 Dec 2000 19:42:28 -0500
Received: from james.kalifornia.com ([208.179.0.2]:2930 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129774AbRAAAmO>; Sun, 31 Dec 2000 19:42:14 -0500
Message-ID: <3A4FC9F8.F6036182@linux.com>
Date: Sun, 31 Dec 2000 16:06:16 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
CC: John Buswell <johnb@linuxcast.org>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: netfilter + 2.4.0-test10 causes connect:invalid argument
In-Reply-To: <Pine.LNX.4.21.0012272311290.22827-100000@bloatfish.opaquenetworks.net> <20001231192213.C3307@coruscant.gnumonks.org>
Content-Type: multipart/mixed;
 boundary="------------137876DFAB9755FB39833B55"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------137876DFAB9755FB39833B55
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Harald Welte wrote:

> On Wed, Dec 27, 2000 at 11:12:18PM -0500, John Buswell wrote:
> > 1. running 2.4.0-test10 with netfilter/iptables 1.1.2 ping/telnet gives
> > you invalid argument when connecting to ports on local interfaces.
>
> This is a _very_ strange problem. Nobody has erver reported this behaviour
> to us (the netfilter developers).
>
> I've never heared about it and never encountered it by myself. Sounds like
> it is a configuration issue.

Is dev lo up and running?

-d


--------------137876DFAB9755FB39833B55
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

--------------137876DFAB9755FB39833B55--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
