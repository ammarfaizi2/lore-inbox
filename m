Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTJTKwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 06:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTJTKwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 06:52:18 -0400
Received: from mail1.cc.huji.ac.il ([132.64.1.17]:49883 "EHLO
	mail1.cc.huji.ac.il") by vger.kernel.org with ESMTP id S262573AbTJTKwQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 06:52:16 -0400
Message-ID: <3F93BCCB.1050406@mscc.huji.ac.il>
Date: Mon, 20 Oct 2003 12:45:31 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030906
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: rob@landley.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wow.  Suspend to disk works for me in test8. :)
References: <200310200225.11367.rob@landley.net>
In-Reply-To: <200310200225.11367.rob@landley.net>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

>Good grief.  It worked.
>
>echo -n disk > /sys/power/state
>
How long does it take to do suspend to disk?

>
>No special preparations, no funky scripts, I didn't even have to unload any 
>modules or feed strange command line options to grub.  It just... worked.  
>(Even the network connection came back up. :)
>
>Congratulations.
>
>Rob
>
>P.S.  (I am breathlessly waiting for my newly resumed system to panic on me, 
>but so far... :)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


-- 
Liviu Voicu
Assistant Programmer and network support
Computation Center, Mount Scopus
Hebrew University of Jerusalem
Tel: 972(2)-5881253
E-mail: "Liviu Voicu"<pacman@mscc.huji.ac.il>

/**
 * cat /usr/src/linux/arch/i386/boot/bzImage > /dev/dsp
 * ( and the voice of God will be heard! )
 *
 */

Click here to see my GPG signature:
----------------------------------
	http://search.keyserver.net:11371/pks/lookup?template=netensearch%2Cnetennomatch%2Cnetenerror&search=pacman%40mscc.huji.ac.il&op=vindex&fingerprint=on&submit=Get+List


