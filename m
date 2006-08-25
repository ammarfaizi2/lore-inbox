Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422838AbWHYFOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbWHYFOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 01:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbWHYFOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 01:14:53 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:48313 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1422838AbWHYFOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 01:14:52 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, device@lanana.org
Subject: Re: [PATCH] Update Documentation/devices.txt
References: <20060824180927.88742491.zaitcev@redhat.com>
Date: Fri, 25 Aug 2006 07:14:41 +0200
In-Reply-To: <20060824180927.88742491.zaitcev@redhat.com> (Pete Zaitcev's
	message of "Thu, 24 Aug 2006 18:09:27 -0700")
Message-ID: <871wr5s8fy.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pete" == Pete Zaitcev <zaitcev@redhat.com> writes:

 >> Sync Documentation/devices.txt with the new version from the LANANA
 >> site (http://www.lanana.org/docs/device-list/devices-2.6+.txt)

 Pete> This doesn't look like a "sync". More like a "replacement, discarding
 Pete> changes".

Ok, bad choice of words ..

 >> 181 char	Conrad Electronic parallel port radio clocks

 Pete> Please do not apply this.

Please check the thread. The trailing spaces are now removed from the
file at lanana.org and Torben will send a new patch..

-- 
Bye, Peter Korsgaard
