Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268489AbUHQWri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268489AbUHQWri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268498AbUHQWre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:47:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33947 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268522AbUHQWqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:46:13 -0400
Date: Tue, 17 Aug 2004 18:46:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Robert K. Nelson" <rnelson@airflowsciences.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI Bus Parity errors with all Kernels after 2.4.26\
Message-ID: <20040817214612.GB5558@logos.cnet>
References: <41210601.6090202@airflowsciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41210601.6090202@airflowsciences.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 03:07:45PM -0400, Robert K. Nelson wrote:
> I have a machine configuration with runs fine under a variety of older 
> kernels and fails under a variety of newer ones.  I was hoping someone 
> could dircet me to a person who would like to look further into this.
> 
> SCSI Configuration -
> Symbios Logic SYM8951U
>    Quantum Viking II 4.5GB
>    IBM DNES-30917OW 9.0GB
> ASUS SC875 Symbios Logic
>    IOMEGA ZOP 100
>    Pioneer CD-ROM DR U065
> 
> Works under:
>    Various RedHat 4, 5, 6 and 7 systems
>    RedHat 8.0 running 2.4.18
>    RedHat 8.0 running 2.4.20
>    Debian 2.2 running 2.4.5
> 
> Fails under
>    Redhat 9.0 running 2.4.26
>    Suse 9.1 running 2.6.5
>    Debian 3.0
> 
> It fails with a SCSI bus error, either crashing entirely or refusing to 
> mount one or more file systems on the second disk.the second disk. 
> Looks like something has changed, and not for the better for this 
> configuration.
> 
> More information avaiable on request.  I am interested in helping to 
> trace this down.
> 
> Please cc: my personal e-mail in response, since I do not subscribe.

What are the exact error messages? CC linux-scsi@vger.kernel.org
