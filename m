Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWFUGdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWFUGdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWFUGdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:33:07 -0400
Received: from adelie.ubuntu.com ([82.211.81.139]:42924 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S1751093AbWFUGdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:33:06 -0400
Subject: Re: [git pull] ieee1394 tree for 2.6.18
From: Ben Collins <bcollins@ubuntu.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606202001520.5498@g5.osdl.org>
References: <44954102.3090901@s5r6.in-berlin.de>
	 <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
	 <4497D014.1050704@s5r6.in-berlin.de>
	 <Pine.LNX.4.64.0606202001520.5498@g5.osdl.org>
Content-Type: text/plain
Organization: Ubuntu
Date: Wed, 21 Jun 2006 08:32:40 +0200
Message-Id: <1150871560.4517.13.camel@grayson>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 20:07 -0700, Linus Torvalds wrote:
> 
> On Tue, 20 Jun 2006, Stefan Richter wrote:
> > 
> > Here are stat and shortlog; not from the actual git tree but from patches as
> > they went in. Side notes: The spike in the diffstat is whitespace formatting.
> > Sem2mutex and kthread conversions as well as suspend/resume fixes are not
> > complete yet.
> 
> Ok, I pulled, and pushed out, but this tree is really problematic: the 
> authorship info has been dropped entirely, it looks.

Sorry about that. Was caused by the patches coming in to me in non-git,
non-mbox form, and me not taking the time to do each one by hand. Wont
be like that after this.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

