Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUAEU3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbUAEU3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:29:11 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:4365 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S265370AbUAEU3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:29:07 -0500
Date: Mon, 5 Jan 2004 21:29:36 +0100
From: DervishD <raul@pleyades.net>
To: Andrew Walrond <andrew@walrond.org>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird problems with printer using USB
Message-ID: <20040105202936.GE15884@DervishD>
References: <20040105192430.GA15884@DervishD> <200401051950.23418.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200401051950.23418.andrew@walrond.org>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Andrew :)

 * Andrew Walrond <andrew@walrond.org> dixit:
> tried a shorter usb cable and it's worked perfectly ever since. I
> know it sounds unlikely (all the cables were within the 10ft
> allowed for usb1), but it worked for me. Might be worth a try.

    The cable is OK, I've tested with two cables and with a USB
memory stick and all works ok. Seems like the printer doesn't like to
have both the parallel cable and the USB cable plugged at the same
time, but sometimes it worked, so... The final cause seems to be the
size of the file I want to print. The larger, the more chances to
fail. I'll try a new cable tomorrow, probably, but I'll give a newer
kernel a try.

    Thanks :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
