Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWBMLnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWBMLnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWBMLnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:43:50 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:12305 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751238AbWBMLnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:43:50 -0500
Date: Mon, 13 Feb 2006 11:43:40 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: klibc list <klibc@zytor.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] klibc tree status
Message-ID: <20060213114340.GC32626@deprecation.cyrius.com>
References: <43F010F3.5030305@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F010F3.5030305@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Peter Anvin <hpa@zytor.com> [2006-02-12 20:54]:
> I have *NOT* implemented support for the following, which I'm hoping
> has fallen out of use by now:
> 
> 	-> When loading the ramdisk from a block device, stop and
> 	   ask the user for a second disk.

This is most certainly still being used, e.g. in Debian to allow
starting the installer from floppy disks.
-- 
Martin Michlmayr
http://www.cyrius.com/
