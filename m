Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWELQTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWELQTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWELQTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:19:14 -0400
Received: from jacks.isp2dial.com ([64.142.120.55]:516 "EHLO
	jacks.isp2dial.com") by vger.kernel.org with ESMTP id S1751164AbWELQTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:19:14 -0400
From: John Kelly <jak@isp2dial.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
Date: Fri, 12 May 2006 12:19:18 -0400
Message-ID: <200605121619.k4CGJCtR004972@isp2dial.com>
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net> <20060511175143.GH25646@redhat.com> <Pine.LNX.4.61.0605121243460.9918@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605121243460.9918@yvahk01.tjqt.qr>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Hard2Crack: 0.001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006 17:03:56 +0200 (MEST), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
 
>> > smbfs is a bit buggy and has no maintainer.  Change it to shout at the user on
>> > the first five mount attempts - tell them to switch to CIFS.

>> > Come November we'll mark it BROKEN and see what happens.

>Sorry for falling in late but we can't do that.
>Win 98 (95 too?) shared can not be mounted with CIFS, it requires SMBFS.

W98?  He's dead, Jim.


