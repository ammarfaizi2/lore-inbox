Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVAMSNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVAMSNw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVAMSNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:13:42 -0500
Received: from mailhost.ntl.com ([212.250.162.8]:2010 "EHLO
	mta09-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261386AbVAMSK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:10:28 -0500
Message-ID: <41E6D5F8.2040901@gentoo.org>
Date: Thu, 13 Jan 2005 20:11:36 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andres Salomon <dilinger@voxel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-as1
References: <1105605448.7316.13.camel@localhost>
In-Reply-To: <1105605448.7316.13.camel@localhost>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andres Salomon wrote:
> I'm announcing a new kernel tree; -as.  The goal of this tree is to form
> a stable base for vendors/distributors to use for their kernels.  In
> order to do this, I intend to include only security fixes and obvious
> bugfixes, from various sources.  I do not intend to include driver
> updates, large subsystem fixes, cleanups, and so on.  Basically, this is
> what I'd want 2.6.10.1 to contain.

After all of the recent discussion it's nice to see someone step up and do this :)
Thanks a lot, I'm sure I will find it useful when producing gentoo's kernel 
packages..

Just one suggestion- maybe could you distinguish security patches from 
bugfixes? I.e. prepend or append the security patches with "sec" or something?

Thanks,
Daniel

