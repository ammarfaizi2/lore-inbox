Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268465AbUH3UYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268465AbUH3UYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 16:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbUH3UYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 16:24:10 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:2528 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S268465AbUH3UX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 16:23:59 -0400
Date: Mon, 30 Aug 2004 20:23:57 +0000 (UTC)
From: dulle <dulle@free.fr>
Reply-To: dulle@free.fr
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: reverse engineering pwcx
In-Reply-To: <1093870332.434.6983.camel@cube>
Message-ID: <Pine.LNX.4.60.0408301918420.3067@ganymede.chateauneuf.fr>
References: <1093709838.434.6797.camel@cube>  <20040829210436.GA24350@hh.idb.hist.no>
  <Pine.LNX.4.61.0408300836010.2441@fogarty.jakma.org> <1093870332.434.6983.camel@cube>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-350937542-1093896296=:3067"
Content-ID: <Pine.LNX.4.60.0408302013500.3067@ganymede.chateauneuf.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811839-350937542-1093896296=:3067
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN; FORMAT=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.60.0408302013501.3067@ganymede.chateauneuf.fr>

On Mon, 30 Aug 2004, Albert Cahalan wrote:

> On Mon, 2004-08-30 at 03:42, Paul Jakma wrote:
>> On Sun, 29 Aug 2004, Helge Hafting wrote:
>>
>>> There's no need for faith or speculation here.
>>> Put the chip under a microscope and count the pixels,
>>> or rather measure their size and estimate their number.
>>
>> The lavarnd guy did and counted 160x120:
>>
>>  =09http://slashdot.org/comments.pl?sid=3D119578&cid=3D10091208
>
> Unless he explains a bit better, there's no reason
> to assume he counted correctly. There may be a larger
> pattern that was counted by mistake. For example,
> there may be 160x120 red-sensing sub-pixels. He could
> have counted only that.
>
> Also, there is more than one type of sensor that can
> be fitted to these webcam chips. They may vary.

Yes, some have cmos, some have CCDs.

Beside, I am a bit puzzled by the credit that has been
given to that slashdot comment, when a simple search  on
"ccd chip logitech 3000 pro"  provides  a  link  on  the
description of the CCD chip inside that  cam  in  a  few
clicks :

http://www.sony.net/Products/SC-HP/new_tec/ccd/icx098.html

2  more  clicks  on  Sony's  site  give  acces  to   the
datasheets of  the  different  versions  of  the  icx098
(color or b/w).

And that was the hard  way:  if  you  search  "ccd  chip
philips webcam" you have the  reference  on  the  result
page and access to the specs on the first site returned.

http://www.astrosurf.com/benschop/APEquipment.htm

Did I mention icx098 is a 640x480 CCD chip, whatever the
version ?

-- Fran=E7ois Meyer
http://dulle.free.fr/alidade/galerie.php?maxim=3D12
---1463811839-350937542-1093896296=:3067--
