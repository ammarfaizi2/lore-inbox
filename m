Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWJGSX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWJGSX2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 14:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWJGSX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 14:23:27 -0400
Received: from boogie.lpds.sztaki.hu ([193.224.70.237]:40857 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1751499AbWJGSX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 14:23:27 -0400
Date: Sat, 7 Oct 2006 20:23:25 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, caszonyi@rdslink.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Merge window closed: v2.6.19-rc1
Message-ID: <20061007182325.GA9185@boogie.lpds.sztaki.hu>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <Pine.LNX.4.62.0610062041440.1966@grinch.ro> <Pine.LNX.4.64.0610061110050.3952@g5.osdl.org> <m1irixz2mt.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1irixz2mt.fsf@ebiederm.dsl.xmission.com>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 01:05:14PM -0600, Eric W. Biederman wrote:

> That code if it gets -ENOSYS reads /proc/sys/kernel/version,
> and it has worked this way since the day it was written.

What happens if /proc is not mounted (e.g. in a chrooted environment)?

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
