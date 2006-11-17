Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932898AbWKQOFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbWKQOFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933612AbWKQOFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:05:04 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:58854 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932905AbWKQOFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:05:01 -0500
Message-ID: <455DC18C.3050605@s5r6.in-berlin.de>
Date: Fri, 17 Nov 2006 15:05:00 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Chris Leadbeater <chris@webteks.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Kernel.org server problems?
References: <455C79CE.2010800@webteks.co.uk> <200611161740.35628.s0348365@sms.ed.ac.uk> <455CA665.4020701@webteks.co.uk> <200611161838.26952.s0348365@sms.ed.ac.uk>
In-Reply-To: <200611161838.26952.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Thursday 16 November 2006 17:56, Chris Leadbeater wrote:
>> Thanks for letting us know, the regional mirrors (for ftp.kernel.org, at
>> least) seem to work perfectly though.
> 
> Git doesn't seem to be mirrored regionally.

FTP and/or HTTP access to /pub/scm/linux/kernel/git/ seems to be
provided by all mirrors. It's just that they don't run services like
gitweb and maybe rsync. Or does any of the regional mirrors do so?
-- 
Stefan Richter
-=====-=-==- =-== =---=
http://arcgraph.de/sr/
