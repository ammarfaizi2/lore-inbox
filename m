Return-Path: <linux-kernel-owner+w=401wt.eu-S1750853AbXALNZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbXALNZF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 08:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbXALNZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 08:25:05 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:25175 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750853AbXALNZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 08:25:04 -0500
Date: Fri, 12 Jan 2007 14:24:59 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: congwen <congwen@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How can I create or read/write a file in linux device driver?
Message-ID: <20070112132459.GY13675@harddisk-recovery.com>
References: <200701121547221465420@gmail.com> <9a8748490701120227h757d473ctaf5673aa318fe090@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490701120227h757d473ctaf5673aa318fe090@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 11:27:01AM +0100, Jesper Juhl wrote:
> On 12/01/07, congwen <congwen@gmail.com> wrote:
> >Hello everyone, I want to create and read/write a file in Linux kernel or 
> >device driver,
> 
> Don't read/write user space files from kernel space.
> 
> Please search the archives, this get asked a lot and it has been
> explained a million times why it's a bad idea.
> You can also read http://www.linuxjournal.com/article/8110

Rather point to

  http://kernelnewbies.org/FAQ/WhyWritingFilesFromKernelIsBad


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
