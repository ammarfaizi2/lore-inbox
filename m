Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbULMOie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbULMOie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbULMOie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:38:34 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:49630 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261220AbULMOic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:38:32 -0500
Date: Mon, 13 Dec 2004 15:38:31 +0100
From: bert hubert <ahu@ds9a.nl>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org,
       samba-technical@lists.samba.org
Subject: Re: cifs large write performance improvements to Samba
Message-ID: <20041213143831.GA3743@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org,
	linux-cifs-client@lists.samba.org, samba-technical@lists.samba.org
References: <1102916738.5937.48.camel@smfhome.smfdom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102916738.5937.48.camel@smfhome.smfdom>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 11:45:38PM -0600, Steve French wrote:

> Running with a faster processor (otherwise the same) this improved to
> 19.3 seconds average (and using the even larger 120K write size
> performance dropped slightly to 20.6 seconds)

While this is all supremely cool, my inbox has several reactions from cifs
users about my never addressed query [1] on linux-cifs-clients regarding memory
leaks you can drive a truck through in cifs.

[1] http://marc.theaimsgroup.com/?l=linux-cifs-client&m=109221678006861&w=2

I'd love to deploy cifs and I've recommended it to many people, they've all
switched back to smbfs!

Now while I fully understand open source ethics (breaks, both pieces etc),
I'd really hope cifs would shape up in terms of ""enterprise reliability"".

Anything I can do to help, let me know. The referred URL contains some of my
conclusions at the time.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
