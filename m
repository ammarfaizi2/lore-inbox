Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWJ3Xyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWJ3Xyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWJ3Xyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:54:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56837 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932478AbWJ3Xyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:54:31 -0500
Date: Tue, 31 Oct 2006 00:54:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb device descriptor read/64, error -110
Message-ID: <20061030235429.GO27968@stusta.de>
References: <45468ABC.1060100@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45468ABC.1060100@perkel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 03:29:00PM -0800, Marc Perkel wrote:
> Running the latest FC6 kernel based on 2.6.18.1. What does this error mean?
> 
> device descriptor read/64, error -110
> 
> Is this a kernel bug? Thanks in advance?

That's a timeout.

Your bug report lacks any any information for further debugging your 
problem.

- When does it occur?
- What is failing?
- Please send the output of "dmesg -s 1000000".

And please read and follow REPORTING-BUGS in the kernel sources before 
sending your next bug report.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

