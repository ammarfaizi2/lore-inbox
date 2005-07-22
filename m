Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVGVMri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVGVMri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 08:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVGVMrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 08:47:32 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:2872 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261257AbVGVMrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 08:47:31 -0400
Date: Fri, 22 Jul 2005 14:47:30 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: often ide errors on amd64 / A8N-SLI
Message-ID: <20050722124730.GF20258@harddisk-recovery.com>
References: <20050721172648.GA21124@amd64.of.nowhere> <1121974214.19424.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121974214.19424.22.camel@localhost.localdomain>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 08:30:13PM +0100, Alan Cox wrote:
> There was corruption on the cable between the controller and drive. That
> usually indicates a cable or noise problem in the PC but could indicate
> mistuning of the interface. Make sure the IDE cable is 
> 
> 
>  [controller]<---- long section ----->[slave]--short section-->[master]
> 
> 
> as one common cause is having the cable the other way around.

Another common cause is to have the master and slave swapped. The
master should be at the end of the cable.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
