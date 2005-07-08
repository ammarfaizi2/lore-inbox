Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVGHMXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVGHMXh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVGHMXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:23:19 -0400
Received: from gw.alcove.fr ([81.80.245.157]:37286 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S262594AbVGHMV6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:21:58 -0400
Subject: Re: GIT tree broken? (rsync depreciated)
From: Stelian Pop <stelian@popies.net>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200507080728.17192.tomlins@cam.org>
References: <Pine.SOC.4.61.0507081227540.25021@math.ut.ee>
	 <1120816858.4688.4.camel@localhost.localdomain>
	 <200507080728.17192.tomlins@cam.org>
Content-Type: text/plain; charset=utf-8
Date: Fri, 08 Jul 2005 14:20:25 +0200
Message-Id: <1120825225.4689.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry Ed for the duplicate...]

Le vendredi 08 juillet 2005 à 07:28 -0400, Ed Tomlinson a écrit :
> Hi,
> 
> I resync(ed) cg and rebuild this morning and it worked fine.  
> 
> On another tack.  Updating the kernel gave a message that rsync is
depreciated and
> will soon be turned off.  How should we be updating git/cg trees now?

After resyncing cogito to the latest version (which incorporates the
'pack' changes, which were causing the failure), it does indeed work
again, when using rsync.

However, it still fails when using http.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

