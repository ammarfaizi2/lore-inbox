Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266309AbUA2Tc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266321AbUA2Tc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:32:56 -0500
Received: from users.linvision.com ([62.58.92.114]:42440 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S266309AbUA2Tcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:32:54 -0500
Date: Thu, 29 Jan 2004 20:32:51 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Thomas Davis <tadavis@lbl.gov>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Can't boot a 2.6 kernel..
Message-ID: <20040129193251.GA31524@bitwizard.nl>
References: <40195C71.8080608@lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40195C71.8080608@lbl.gov>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 11:18:09AM -0800, Thomas Davis wrote:
> Ok, I'm trying to get a 2.6 kernel to boot on my desktop here at work.
> 
> I have tried 3 different kernels - 2.6.1, 2.6.2rc1, and arjanv's 2.6.1 
> kernel.
> 
> After the grub prompt, I get the grub kernel description, and then..
> 
> Nothing. Nada. Zip. Zilch.
> 
> 2.4 kernels boot and works fine; I've attached the dmesg output of one of 
> it's boots.
> 
> Any ideas on what to try?

I hope you read the post-halloween document, especially the part about
"Known gotchas"? See http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
