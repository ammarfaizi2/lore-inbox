Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270991AbTGPTKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271022AbTGPTKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:10:14 -0400
Received: from [66.212.224.118] ([66.212.224.118]:44549 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270991AbTGPTKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:10:12 -0400
Date: Wed, 16 Jul 2003 15:13:41 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: nuno.monteiro@ptnix.com, linux-kernel@vger.kernel.org
Subject: Re: woes with 2.6.0-test1 and xscreensaver/xlock
In-Reply-To: <20030716121627.0ac0d238.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.53.0307161512060.32541@montezuma.mastecende.com>
References: <20030716172758.GA1792@hobbes.itsari.int>
 <Pine.LNX.4.53.0307161454180.32541@montezuma.mastecende.com>
 <20030716121627.0ac0d238.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003, Randy.Dunlap wrote:

> It happens to me all the time (so I stopped using xscreensaver).
> 
> Alan says that it's fixed in RH 9 IIRC, but no details about the
> problem or the fix.... ?  Sounds a little like a userspace (library
> or syscall) issue.  Someone mentioned PAM also.

Aha! The machine i tested it on was RH9, i'll have to try this on 7.3 (w/o 
updates) but yes, it sounds like a userspace problem.

Thanks,
	Zwane
-- 
function.linuxpower.ca
