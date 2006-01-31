Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWAaVaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWAaVaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWAaVaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:30:16 -0500
Received: from mail.suse.de ([195.135.220.2]:39873 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751507AbWAaVaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:30:15 -0500
Date: Tue, 31 Jan 2006 22:30:09 +0100
From: Olaf Hering <olh@suse.de>
To: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-kernel@vger.kernel.org
Subject: Re: qla2xxx related oops in 2.6.16-rc1
Message-ID: <20060131213009.GA27795@suse.de>
References: <43DA580E.3020100@madness.at> <20060130153435.GC1160@andrew-vasquezs-powerbook-g4-15.local> <20060131100710.GA3039@suse.de> <43DFD542.7090508@madness.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43DFD542.7090508@madness.at>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jan 31, Stefan Kaltenbrunner wrote:

> After applying Andrews patches I have so far failed to reproduce the
> issue again - but I'm not really convinced that it is really gone now
> since I could not trigger it very reliably before too ...

I hit that several times, and will track it down once my memcorruption
bug is sorted out.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
