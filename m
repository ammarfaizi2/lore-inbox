Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282129AbRLQS4I>; Mon, 17 Dec 2001 13:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282187AbRLQSz6>; Mon, 17 Dec 2001 13:55:58 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:8711 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S282129AbRLQSzl>; Mon, 17 Dec 2001 13:55:41 -0500
Message-ID: <3C1E12A3.5955B8F6@cyclades.com>
Date: Mon, 17 Dec 2001 12:43:31 -0300
From: Daniela Squassoni <daniela@cyclades.com>
Organization: Cyclades
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.4.9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: dscc4 and new Generic HDLC Layer
In-Reply-To: <3C19CA22.E604CB32@cyclades.com>
		<20011214151518.B30306@xyzzy.org.uk> <m31yhwppzq.fsf@defiant.pm.waw.pl>
Content-Type: multipart/mixed;
 boundary="------------859B4E3D27C4266341800C86"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------859B4E3D27C4266341800C86
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Krzysztof Halasa wrote:
> 
> Anyway, incremental patch is better, I'm going to submit my paches
> to 2.5 after some features (FR InARP, DCD handling, probably FR bridging)
> are added and tested.
> 
> Seems it's better to include that things in 2.4 when it works fine.
> Especially if all drivers are updated.
> 2.5 first - of course.

How long do you think it will take to include the last changes in 2.4?
Isn't it possible to submit a patch without these new features, just to
speed up this process? Is there anything else that still need to be done
before you submit it?

It seems that there is a consensus that maintaining this out of the
kernel is causing some overhead to the drivers maintainers...

Best regards,

Daniela
--------------859B4E3D27C4266341800C86
Content-Type: text/x-vcard; charset=us-ascii;
 name="daniela.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Daniela Squassoni
Content-Disposition: attachment;
 filename="daniela.vcf"

begin:vcard 
n:Squassoni;Daniela
x-mozilla-html:FALSE
org:Cyclades;R&D
adr:;;;;;;
version:2.1
email;internet:daniela@cyclades.com
title:Software Engineer
x-mozilla-cpt:;-3392
fn:Daniela Squassoni
end:vcard

--------------859B4E3D27C4266341800C86--

