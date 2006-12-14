Return-Path: <linux-kernel-owner+w=401wt.eu-S1751991AbWLNXpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbWLNXpN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWLNXpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:45:13 -0500
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:57068 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751991AbWLNXpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:45:10 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 18:45:10 EST
X-AntiVirus: PTMail-AV 0.3-0.88.6
Subject: Re: kernel.org lies about latest -mm kernel
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Pavel Machek <pavel@ucw.cz>, webmaster@kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>, hpa@zytor.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061214223718.GA3816@elf.ucw.cz>
References: <20061214223718.GA3816@elf.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Dec 2006 23:38:28 +0000
Message-Id: <1166139508.17998.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.org don't lie is not updated ,
this problem should be snd to webmaster isn't ? 

--
Sérgio M. B.

On Thu, 2006-12-14 at 23:37 +0100, Pavel Machek wrote:
> Hi!
> 
> pavel@amd:/data/pavel$ finger @www.kernel.org
> [zeus-pub.kernel.org]
> ...
> The latest -mm patch to the stable Linux kernels is: 2.6.19-rc6-mm2
> pavel@amd:/data/pavel$ head /data/l/linux-mm/Makefile
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 19
> EXTRAVERSION = -mm1
> ...
> pavel@amd:/data/pavel$
> 
> AFAICT 2.6.19-mm1 is newer than 2.6.19-rc6-mm2, but kernel.org does
> not understand that.
> 								Pavel
> 

