Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVDVCGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVDVCGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 22:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVDVCGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 22:06:43 -0400
Received: from fmr19.intel.com ([134.134.136.18]:27620 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261919AbVDVCGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 22:06:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17000.23588.462823.574142@sodium.jf.intel.com>
Date: Thu, 21 Apr 2005 19:06:28 -0700
To: Petr Baudis <pasky@ucw.cz>
Cc: tony.luck@intel.com, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: ia64 git pull
In-Reply-To: <20050422015340.GD7443@pasky.ji.cz>
References: <200504212042.j3LKgng04318@unix-os.sc.intel.com>
	<Pine.LNX.4.58.0504211403080.2344@ppc970.osdl.org>
	<200504212155.j3LLtho04949@unix-os.sc.intel.com>
	<200504212301.j3LN1Do05507@unix-os.sc.intel.com>
	<20050422012546.GD1474@pasky.ji.cz>
	<17000.22515.170455.192374@sodium.jf.intel.com>
	<20050422015340.GD7443@pasky.ji.cz>
X-Mailer: VM 7.19 under Emacs 21.3.1
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Petr Baudis <pasky@ucw.cz> writes:

> Remember that it's an URL (so you can't use '%'), and '#' is the
> canonical URL fragment identifier delimiter. (And fragments are
> perfect for this kind of thing, if you look at the RFC, BTW.)

Ouch, true--rule out %...

> Still, why would you escape it? My shell will not take # as a
> comment start if it is immediately after an alphanumeric character.

Well, you just taught me something about bash I didn't know....

/me goes back to his hole with some more knowledge.

Thanks,

-- 

Inaky

