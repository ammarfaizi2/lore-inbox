Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWBWMBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWBWMBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWBWMBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:01:50 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:61384 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1750754AbWBWMBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:01:49 -0500
To: Jason Lunz <lunz@falooley.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suspend to ram: request for testing
In-Reply-To: <m2n.1FC8z9-007iP2@chiark.greenend.org.uk>
References: <20060221211207.GA22592@elf.ucw.cz> <m2n.1FC8z9-007iP2@chiark.greenend.org.uk>
Date: Thu, 23 Feb 2006 12:01:49 +0000
Message-Id: <E1FCFAL-0006N4-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz <lunz@falooley.org> wrote:
> pavel@suse.cz said:
>> In www.sf.net/projects/suspend 's CVS, there is a new version of s2ram
>> program. Now it includes vbetool, and long whitelist copied from
>> acpi_support-0.52 (thanks!).
> 
> Is there any hope of s2ram/vbetool working on amd64?

The latest version of vbetool should do, though there's a couple of 
bugfixes to come. Works fine on my amd64 laptop.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
