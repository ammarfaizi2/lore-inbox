Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264431AbTH1WQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTH1WPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:15:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:2451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264423AbTH1WPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:15:18 -0400
Date: Thu, 28 Aug 2003 15:15:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Breno <brenosp@brasilsec.com.br>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: non-exec stack
Message-ID: <20030828151501.A24595@osdlab.pdx.osdl.net>
References: <001801c3860b$ab8e5560$3fdfa7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001801c3860b$ab8e5560$3fdfa7c8@bsb.virtua.com.br>; from brenosp@brasilsec.com.br on Sun, Sep 28, 2003 at 06:58:36PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Breno (brenosp@brasilsec.com.br) wrote:
> Hi , Is there an source that allow non-exec stack for linux ? like openbsd
> do.

Have you looked at Openwall Linux or exec-shield?

http://www.openwall.com/linux/
http://people.redhat.com/mingo/exec-shield/

of course, neither is a complete security solution, just a small bit of
protection.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
