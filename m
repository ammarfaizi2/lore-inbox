Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTLDBHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTLDBHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:07:50 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:4290 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262795AbTLDBHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:07:49 -0500
Message-ID: <3FCE8904.4010909@myrealbox.com>
Date: Wed, 03 Dec 2003 17:08:20 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <fa.nmlihqm.16j6n38@ifi.uio.no> <fa.f27m7i8.1vk0j84@ifi.uio.no>
In-Reply-To: <fa.f27m7i8.1vk0j84@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh McKinney wrote:
> To me the strangest thing is that when I first got this board a month or
> so ago it would hang with APIC or LAPIC enabled.  Now it works fine
> without disabling APIC.  All I did was update the BIOS and use it for a
> while with APIC disabled...

Does the new BIOS use different defaults for memory timing, bus speed, etc?
Did you change any of the default settings in the BIOS?

