Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTKZLGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 06:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTKZLGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 06:06:10 -0500
Received: from web13906.mail.yahoo.com ([216.136.175.69]:57361 "HELO
	web13906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264151AbTKZLGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 06:06:00 -0500
Message-ID: <20031126110558.16044.qmail@web13906.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Wed, 26 Nov 2003 03:05:58 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Hp/Compaq Fibre HBA
To: linux-kernel@vger.kernel.org
Cc: fms@istop.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Did I send this question to the wrong group?
>
>On Mon, 2003-11-24 at 13:18, Danny Brow wrote:
>> Any one know if there are drivers for a storageworks fibre channel
host
>> bus adapter /p. The chip set is Tachyon HPFC-5000c/3.0, the card
also
>> has this number on it HHBA - 5000A.
>>
>> TIA,
>>
>> Dan.
>>
Dan,

 not sure about the group. Maybe it is just that nobody has a good
answer. I was having similar problems with regard to another Tachyon
[XL2]based HP card.Lack of Linux support prevented basically a working
dual-boot solution (HP-UX vs. Linux) on couple of rx5670 boxes.

 At that time a nice folk at HP basically told me that: "it could be
done, but we are looking for funding one or two consultants".

 One of the problems involved seems to be documentation on the Tachyon
chips. As usual.  Another reason (for those liking conspiracy theories)
might be market(ing) segmentation by HP. But I'm just being paranoid
here :-)

Martin
PS: have a look at http://sourceforge.net/projects/cpqfc - but I fear
it is not very actively maintained :-(



=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
