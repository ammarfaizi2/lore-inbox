Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbSLCLgr>; Tue, 3 Dec 2002 06:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266259AbSLCLgr>; Tue, 3 Dec 2002 06:36:47 -0500
Received: from mta05bw.bigpond.com ([139.134.6.95]:37847 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S266250AbSLCLgq>; Tue, 3 Dec 2002 06:36:46 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Input core support required for non-USB joystick
Date: Tue, 3 Dec 2002 22:33:07 +1100
User-Agent: KMail/1.4.5
References: <200212031129.gB3BThpw000597@darkstar.example.net>
In-Reply-To: <200212031129.gB3BThpw000597@darkstar.example.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200212032233.07229.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 3 Dec 2002 22:29, John Bradford wrote:
> Using 2.4.20, (and possibly earlier versions, I haven't checked), it's
> necessary to enable input core support, before non-USB joystick support can
> be enabled.
>
> I thought that input core support related to USB specifically, is that
> incorrect?
It is incorrect. 
When the input core support first went in, the old methods for handling 
joysticks went out.

Where do you think the low major number came from? :-)

Brad
- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE97JZzW6pHgIdAuOMRAupbAKCHU9vO8pm+VAEVWLLVOFksbUBf2wCgwLa3
finKg+8NUVTtqhrhvtW65y0=
=Qftd
-----END PGP SIGNATURE-----

