Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVEFWh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVEFWh6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVEFWhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:37:53 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:42946 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261306AbVEFWge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:36:34 -0400
Message-ID: <427BF168.6010705@tiscali.de>
Date: Sat, 07 May 2005 00:36:24 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: christos gentsis <christos_gentsis@yahoo.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: why can i see a floppy?
References: <427BF378.5050400@yahoo.co.uk>
In-Reply-To: <427BF378.5050400@yahoo.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christos gentsis wrote:
> hello anyone
> 
> i just install the 2.6.11.8 kernel to my SUSE 9.2 pro box and the 
> problem is that then i open the GNOME i had a message that there is a 
> floppy drive found and ask me if i want to configure it... the odd in 
> this situation is that _I_don't_have_a_floppy_ to this pc...
> 
> in the details says that the device is available but not configured... 
> what is going on?
> can anyone help me?
> 
> thanks
> christos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Open your gnome terminal and run the following command: "dmesg". Post the 
ouput here.

Matthias-Christian Ott
