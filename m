Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbUKPWo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUKPWo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUKPWo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:44:58 -0500
Received: from CPE-203-51-35-114.nsw.bigpond.net.au ([203.51.35.114]:47094
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261872AbUKPWou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:44:50 -0500
Message-ID: <419A82DD.7000604@eyal.emu.id.au>
Date: Wed, 17 Nov 2004 09:44:45 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 usb-storage too verbose
References: <4199CAF8.1000501@eyal.emu.id.au> <1100630448.1817.5.camel@kuecken.unki.net>
In-Reply-To: <1100630448.1817.5.camel@kuecken.unki.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Unterkircher wrote:
> don't know your .config & kernel version - but possible u should disable
> CONFIG_USB_STORAGE_DEBUG there ;)

*red face*

Very true. Turns out every DEBUG option is turned on in my config. I surely
never do this, don't know how it happened. I was so convince that it cannot
be that I did not check the obvious thing...

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
