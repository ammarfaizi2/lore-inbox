Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUHCMly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUHCMly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 08:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUHCMly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 08:41:54 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:64506 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S266128AbUHCMlx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 08:41:53 -0400
Subject: Re: secure computing for 2.6.7
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Hans Reiser <reiser@namesys.com>
Cc: andrea@cpushare.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <40EC4E96.9090800@namesys.com>
References: <20040704173903.GE7281@dualathlon.random>
	 <40EC4E96.9090800@namesys.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1091536845.7645.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 08:40:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-07 at 15:27, Hans Reiser wrote:
> Am I right to think that this could complement nicely our plans 
> described at www.namesys.com/blackbox_security.html

Hi Hans,

Out of curiosity, what do you think that this proposal will achieve that
cannot already be done via SELinux policy?  SELinux policy can already
express access rules based not only on the executable and user, but even
the entire call chain that led to a given executable.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

