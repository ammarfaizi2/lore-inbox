Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbRCaPIf>; Sat, 31 Mar 2001 10:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRCaPI0>; Sat, 31 Mar 2001 10:08:26 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:54541 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132416AbRCaPIO>; Sat, 31 Mar 2001 10:08:14 -0500
Message-Id: <200103311507.f2VF7Ns50937@aslan.scsiguy.com>
To: Armin Obersteiner <armin@xos.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: add-single-device won't work in 2.4.3 
In-Reply-To: Your message of "Sat, 31 Mar 2001 15:52:40 +0200."
             <20010331155240.A888@elch.elche> 
Date: Sat, 31 Mar 2001 08:07:23 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>hi!
>
>as in the subject, yesterday i upgraded to 2.4.3 (plain, no patches).
>add-single-device/del-single-device did not work anymore.
>
>tried with:
>
>controller: adaptec-19160
>device: yamaha-4260

Do you get any error messages?  Does the problem persist with
the latest driver?

http://people.FreeBSD.org/~gibbs/linux

Use the 2.4.3-pre6 patch.

--
Justin
