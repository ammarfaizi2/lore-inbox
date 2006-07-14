Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161143AbWGNQCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbWGNQCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbWGNQCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:02:17 -0400
Received: from lecar.isp.oct.net ([216.147.229.12]:60933 "EHLO
	lecar.isp.oct.net") by vger.kernel.org with ESMTP id S1161143AbWGNQCQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:02:16 -0400
Message-ID: <44B7BFF7.1000500@ksu.edu>
Date: Fri, 14 Jul 2006 11:01:59 -0500
From: "Scott J. Harmon" <harmon@ksu.edu>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org> <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org> <20060714154240.GA23480@tuatara.stupidest.org>
In-Reply-To: <20060714154240.GA23480@tuatara.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Fri, Jul 14, 2006 at 07:43:05AM -0700, Andrew Morton wrote:
> 
>> How do we fix all this?  (Who owns it?)
> 
> If someone who has this problem with ACPI is enabled can verify that
> Windows works that would be helpful, then we might be able to figure
> out why CONFIG_ACPI=y doesn't suffice for *some* people.  I've been
> told that VIA got their ACPI wrong in some cases so that might be why
> it doesn't work --- but if Windows deals with it we might be able to
> do whatever windows does in this case.

Windows worked when I had it installed.

> 
> Doing the quick blindly as we did before (and current -mm does) breaks
> for some people and trying to list all the IDs breaks for others
> (apparently a larger or certainly louder group).

Thanks,

Scott.

