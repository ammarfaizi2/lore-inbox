Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUHTOB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUHTOB3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267328AbUHTOB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:01:29 -0400
Received: from main.gmane.org ([80.91.224.249]:27098 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266884AbUHTOBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:01:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Daniel Pittman <daniel@rimspace.net>
Subject: Re: [RFC] IBM thinkpad Fn+Fx key driver
Date: Fri, 20 Aug 2004 23:19:20 +1000
Message-ID: <87pt5mueuf.fsf@enki.rimspace.net>
References: <20040820122809.GA6167@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203-217-29-45.perm.iinet.net.au
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.4 (Security Through
	Obscurity, linux)
Cancel-Lock: sha1:0aCeB275P+UH2TRxgNxwBvEMbyQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Aug 2004, Erik Rigtorp wrote:
> I've written a driver for some of the extra keys on the thinkpads. The
> supported keys are: Fn+ F3, F4, F5, F7, F8, F9, F12. It has been tested on
> two diffrent thinkpad x31, but I would like some feedback from testing on
> other thinkpads. 
>
> http://rigtorp.se/files/src/thinkpad-acpi.tar.gz

Borislav Deianov (borislav@users.sourceforge.net) has recently posted a
similar Thinkpad ACPI driver on the Thinkpad hardware list, and it has a
number of success reports.

He has apparently taken off on holiday, but you can find the code here:
http://bkernel.sf.net/tmp/ibm-acpi-0.3.tar.gz

Perhaps you should talk to him about merging the code, and then working
together to get this into the kernel?

I believe that he has also been in touch with the ACPI development list.


Anyway, it is good to see Thinkpad specific ACPI support on the way --
being able to software control my Bluetooth adapter would be nice. :)

Regards,
        Daniel
-- 
Beware of all enterprises that require new clothes.
        -- Henry David Thoreau

