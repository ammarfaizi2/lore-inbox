Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSHNXSv>; Wed, 14 Aug 2002 19:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSHNXSv>; Wed, 14 Aug 2002 19:18:51 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:31899 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S315988AbSHNXSt>;
	Wed, 14 Aug 2002 19:18:49 -0400
Date: Thu, 15 Aug 2002 01:22:42 +0200
From: David Weinehall <tao@acc.umu.se>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPG/PGP-signatures
Message-ID: <20020814232242.GZ259@khan.acc.umu.se>
References: <20020814210449.GV259@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020814210449.GV259@khan.acc.umu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 11:04:50PM +0200, David Weinehall wrote:
> I think that it is great that people GPG/PGP-sign their posts
> (and I intend to start doing so myself, as soon as I get proper
> connectivity at home, and thus don't have to send all e-mail via a
> remote server where I don't want to store my private key), but when the
> public keys are unavailable, hard to obtain, or invalid for one reason
> or another, the signing is useless.
> 
> I've monitored the use of signatures on the list the last few
> months, and have come up with this list of people whose signatures
> I've been unable to find (neither available on wwwkeys.pgp.net nor
> has a x-pgp or x-gpg header saying where to download the key):
> 
> Justin Carlson		C1A06FBE
> Florent Chabaud		95C81C3C
> Thomas Duffy		38F3C1BC
> David Fries		CB1EE8F0
> Roger Gammans		88DE0B3E
> Austin Gonyou		59853282
> Josh Litherland		893D9228
> Brandon Low		1F012DC6
> John L. Males		99ED3565
> Brendan W. McAdams	82306710
> Solomon Peachy		2DBBE7D0
> Joe Radinger		F957E8F3
> Udo A. Steinberg	233B9D29
> Gianni Tedesco		8646BE7D
> Martin Waitz		DFE80FB2
> Derek James Witt	972FE938
> Wiktor Wodecki		A1559FE7
> Pete de Zwart		984AF710
> 
> I've bcc:d all of the above.
> 
> For those who who possibly don't know how to upload their public key
> to a public server, here's how:
> 
> gpg --keyserver wwwkeys.pgp.net --send-keys <keyid>

As a followup to my own post, I found the public keys for the following
persons on search.keyserver.net (thanks to Roger Gammans for the hint!);

Brandon Low
Solomon Peachy
Pete de Zwart
Gianno Tedesco (seems to have a broken mail-client; the signatures on
his posts are BAD, at least according to mutt/gnupg v1.0.7)
Roger Gammans

Finally a recommendation:

add

x-gpg-fingerprint: <fingerprint>
x-gpg-key: <url to your key or a keyserver>

to your mail-headers.


Regards: David Weinehall
-- 
 /> David Weinehall <tao@acc.umu.se> /> Northern lights wander      <\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
