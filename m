Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVKVQVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVKVQVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVKVQVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:21:50 -0500
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:14210 "EHLO
	sade.emperorlinux.com") by vger.kernel.org with ESMTP
	id S1751314AbVKVQVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:21:49 -0500
Message-ID: <4383454D.4080400@emperorlinux.com>
Date: Tue, 22 Nov 2005 11:20:29 -0500
From: Josh Litherland <josh@emperorlinux.com>
Organization: EmperorLinux, Inc
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, research@emperorlinux.com
Subject: Re: SATA ICH6M problems on Sharp M4000
References: <43824A6F.6070407@emperorlinux.com> <20051121234119.GD24565@havoc.gtf.org>
In-Reply-To: <20051121234119.GD24565@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Expected behavior, since the default for module option atapi_enabled
> is zero (disabled).

Thanks, turning this on makes everything work as expected.  Out of
curiosity, in your opinion is atapi in libata still not quite ready for
production use ?

Thanks to everyone who helped us track this down.

-- 
Josh Litherland (josh@emperorlinux.com)
Emperor Linux, Inc.
