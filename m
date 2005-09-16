Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbVIPNzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbVIPNzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 09:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbVIPNzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 09:55:33 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:63408 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1161094AbVIPNzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 09:55:33 -0400
Message-ID: <20050916155514.gtc8dd99kdi4gk4c@mouette.ens-lyon.fr>
Date: Fri, 16 Sep 2005 15:55:14 +0200
From: abuisse@ens-lyon.fr
To: rml@novell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] hdaps driver update, updated.
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/05, Robert Love <rml@novell.com> wrote:

    On Wed, 2005-09-14 at 11:57 -0400, Robert Love wrote:

    Mr Morton,

> The hdaps driver landed in 2.6.14-rc1.
>
> The attached patch updates the driver:
>
>       - Remove the relative input device
>       - Add an absolute input device
>       - Misc. cleanup and bug fixing


Hi,

I understand that the "echo 1 > mousedev" has changed and that we are now
supposed to use joydev, but I can't find any joydev related thing in /sys.
Could you please explain how using hdaps as an input device is now supposed to
work ?

Thanks a lot.

Regards,
Alexandre

PS: please excuse me if you receive this email twice

