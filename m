Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVCBK6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVCBK6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 05:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVCBK6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 05:58:15 -0500
Received: from news.suse.de ([195.135.220.2]:486 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262261AbVCBK5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 05:57:52 -0500
Message-ID: <42259C1C.5080202@suse.de>
Date: Wed, 02 Mar 2005 11:57:32 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz> <4225945A.5010005@suse.de>
In-Reply-To: <4225945A.5010005@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Seyfried wrote:
> Pavel Machek wrote:
>> Hi!
> 
>> Table of known working systems:
>> 
>> Model                           hack (or "how to do it")
>> ------------------------------------------------------------------------------
> 
> IBM Thinkpad T20 (S3 Inc. 86C270-294 Savage/IX-MV), model 2647-44G
> "Just works" out of the box. S1 works, too but does not switch off the
> backlight and looks "interesting", but does not crash.

Vesafb is "interesting" also after S3, but X continues to work :-)
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
