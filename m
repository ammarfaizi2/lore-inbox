Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264966AbUFAJwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUFAJwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264968AbUFAJwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:52:36 -0400
Received: from host125-180.pool8174.interbusiness.it ([81.74.180.125]:34178
	"EHLO apollo.survival") by vger.kernel.org with ESMTP
	id S264966AbUFAJwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:52:35 -0400
Message-ID: <20040601094948.20990.qmail@apollo.survival>
From: "Marco Marabelli" <mm@smrt.it>
To: linux-kernel@vger.kernel.org
Subject: Re: probls upgrading ram on a 2.4 linuxbox
Date: Tue, 01 Jun 2004 11:49:48 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

 

On Tuesday 01 June 2004 12:19, Marco Marabelli wrote:
> > Hi all!
> > As subject I upgraded my box from 1GB ram to 2GB ram; bios sees all
> >new memory but kernel doesn'load (error in memory stack).

>Details??

> > I have the kernel set with CONFIG_HIGHMEM4G.
> > I googled everywhere but didn't find any similar problem.
> > Anyone has a suggestion?
> > linux 2.4.18 (slackware) on 2x1.6 athlon processor, ram266Mhz no ECC.
> -- 
> vda

Unfortunately I didn't note exactly the error output, I will try tonight 
again (it's a server on production), but:
 - with 2GB, after lilo black screen ...
 - with 1.5GB, the kernel stops after detecting SCSI drive, with a long 
output that explaned a memory error in stack ...
 - obviously, rebooting with 1GB everything works ...
in a few hours I can report in ML the details ... (waiting for offices to 
close) 

thanks in advice,
Marco Marabelli
