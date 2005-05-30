Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVE3JfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVE3JfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVE3JfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:35:00 -0400
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:49675 "EHLO
	mail.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S261576AbVE3Je2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:34:28 -0400
Date: Mon, 30 May 2005 11:34:20 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: "Lincoln Dale (ltd)" <ltd@cisco.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, dtor_core@ameritech.net,
       mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050530093420.GB15347@hout.vanvergehaald.nl>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 05:19:43PM +0800, Lincoln Dale (ltd) wrote:
> > But what you claim is simply impossible.
> 
> wrong. again.
> 
> look up the man page for udev(8), pay particular attention to the part
> that can tie devname into device serial number.
> take note of the example shown under 'serial'.

These were my thoughts too.
But I just checked the entries in my sysfs tree for my CDRW drive,
and there is no serial number available...

Regards,
Toon.
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
