Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270707AbTG0J7o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 05:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270709AbTG0J7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 05:59:44 -0400
Received: from outmail.cc.huji.ac.il ([132.64.1.17]:6035 "EHLO
	mail1.cc.huji.ac.il") by vger.kernel.org with ESMTP id S270707AbTG0J7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 05:59:43 -0400
Message-ID: <3F239AE5.9010403@mscc.huji.ac.il>
Date: Sun, 27 Jul 2003 12:27:01 +0300
From: Voicu Liviu <pacman@mscc.huji.ac.il>
Organization: Hebrew University of Jerusalem
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030713
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig
References: <3F2391EF.8080707@mscc.huji.ac.il> <20030727100017.GB21246@mars.ravnborg.org>
In-Reply-To: <20030727100017.GB21246@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (pluto.mscc.huji.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Sun, Jul 27, 2003 at 11:48:47AM +0300, Voicu Liviu wrote:
> 
>>Hi dear list,
>>I have heard that "make menuconfig" for kernel 2.6-beta1 is deprecated? 
>>Am I correct? If yes then how do I get into the config?
> 
> You are wrong - make menuconfig is still OK.
> Mak sure to read the document made by dave j. before playing too much
> with 2.6.
> It is at: www.codemonkey.org.uk - but I cannot get in contact with it
> right now.
> See instead:
> http://lwn.net/Articles/39901/
> 
> 
>>Alos tryied to run 'make menuconfig' from tcsh and got error like: 
>>Missing }.
> 
> Works for me. Could you provide exact error-message etc.

liviu@starshooter liviu $ su
Password:
liviu has logged on pts/0 from :0.0.
liviu has logged on pts/1 from :0.0.
liviu has logged on vc/1 from local.
liviu has logged on vc/2 from local.
starshooter /root# cd /usr/src/linux
starshooter src/linux# make menuconfig
Missing }.
starshooter src/linux#

Liviu
> 
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Voicu Liviu
Rothberg International School
Computation center, Mount Scopus
Hebrew University of Jerusalem
Tel: 972(2)-5881253
E-mail: pacman@mscc.huji.ac.il

System Operating: Linux Gentoo1.4 ( www.gentoo.org )

Click here to see my GPG signature:
	http://search.keyserver.net:11371/pks/lookup?template=netensearch%2Cnetennomatch%2Cnetenerror&search=pacman%40mscc.huji.ac.il&op=vindex&fingerprint=on&submit=Get+List


