Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbRAEBWE>; Thu, 4 Jan 2001 20:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbRAEBVp>; Thu, 4 Jan 2001 20:21:45 -0500
Received: from Cantor.suse.de ([194.112.123.193]:58385 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129962AbRAEBVe>;
	Thu, 4 Jan 2001 20:21:34 -0500
Date: Fri, 5 Jan 2001 02:18:38 +0100 (CET)
From: egger@suse.de
Reply-To: egger@suse.de
Subject: Re: How to Power off with ACPI/APM?
To: crawford@goingware.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A54DC87.5B861B7@goingware.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010105022051.6F0B75232@Nicole.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Jan, Michael D. Crawford wrote:

> I got the message "Power Down" but my system stayed on and I was still
> in my shell.
 
> I'm using the binary of halt that came with Slackware 7.1.  Do I need
> to update any of my executable programs to work with the new kernel? 
> The only thing I've done is installed the latest modutils.  I did
> download the latest util-linux from kernel.org but this didn't appear
> to have the same program Slackware uses - there's a shutdown program,
> but on slackware I think shutdown is a script and there's a halt
> binary with reboot symlinked to it.

 Try the different APM options in the kernel. One will for sure work
 with your system.

-- 

Servus,
       Daniel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
