Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbRDCIB7>; Tue, 3 Apr 2001 04:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131563AbRDCIBt>; Tue, 3 Apr 2001 04:01:49 -0400
Received: from owns.warpcore.org ([216.81.249.18]:64402 "EHLO
	owns.warpcore.org") by vger.kernel.org with ESMTP
	id <S130485AbRDCIBo>; Tue, 3 Apr 2001 04:01:44 -0400
Date: Tue, 3 Apr 2001 03:01:00 -0500
From: Stephen Clouse <stephenc@theiqgroup.com>
To: Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oracle 8I & Kernel 2.4.3 : Sane ?
Message-ID: <20010403030100.B3489@owns.warpcore.org>
In-Reply-To: <986213560.24497.2.camel@olive>
Mime-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.2.5i
In-Reply-To: <986213560.24497.2.camel@olive>; from Yann.Dupont@IPv6.univ-nantes.fr on Mon, Apr 02, 2001 at 02:12:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, Apr 02, 2001 at 02:12:40PM +0200, Yann Dupont wrote:
> Is oracle 8.1.5 + Kernel 2.4.3 a sane combination ?
> In general is oracle + Kernel 2.4 working ?

2.4.3 I can't speak for, but we have been running our development server (Oracle
8.1.6) on 2.4.2 since the day it was released.  No problems whatsoever.

I'd recommend consulting the Oracle docs as to what is screwed with your 
rollback segments.  I highly doubt this is Linux's fault.

- -- 
Stephen Clouse <stephenc@theiqgroup.com>
Senior Programmer, IQ Coordinator Project Lead
The IQ Group, Inc. <http://www.theiqgroup.com/>

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8

iQA/AwUBOsmDOwOGqGs0PadnEQI0qQCdFS+PLvff8YxstOUAB33gSoyRsfkAoKeP
n87LAwm5FrYIjFG8/WXh0IEh
=LCx9
-----END PGP SIGNATURE-----
