Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbTI2F11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 01:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTI2F11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 01:27:27 -0400
Received: from mail2.cc.huji.ac.il ([132.64.1.18]:36739 "EHLO
	mail2.cc.huji.ac.il") by vger.kernel.org with ESMTP id S262803AbTI2F10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 01:27:26 -0400
Message-ID: <3F77C1F9.5040601@mscc.huji.ac.il>
Date: Mon, 29 Sep 2003 08:24:09 +0300
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030906
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Daniel Drake <dan@reactivated.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sound bug ?!
References: <3F76E927.7030809@mscc.huji.ac.il> <3F76F1D5.3000207@reactivated.net>
In-Reply-To: <3F76F1D5.3000207@reactivated.net>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.14; VAE: 6.21.0.1; VDF: 6.21.0.54; host: mail2.cc.huji.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:

> Voicu Liviu wrote:
>
>> Sound bug ?!
>> I also have seen that this 2.6-test6 is missing a few sound 
>> cards(like Ensoniq ES1371) so I was forced to use alsa!
>>
>
> Enable "Gameport support" and you will be able to compile in support 
> for those cards as normal.
>
> Daniel

Thank you,
Liviu

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


