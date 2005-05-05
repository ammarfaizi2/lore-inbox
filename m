Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVEEOm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVEEOm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 10:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVEEOm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 10:42:27 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:622 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262111AbVEEOmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 10:42:24 -0400
Subject: Re: Re[2]: ata over ethernet question
From: "Raf D'Halleweyn" <list@noduck.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1104082357.20050504231722@dns.toxicfilms.tv>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
	 <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
	 <1104082357.20050504231722@dns.toxicfilms.tv>
Content-Type: text/plain
Date: Thu, 05 May 2005 10:42:21 -0400
Message-Id: <1115304141.13054.3.camel@base>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-04 at 23:17 +0200, Maciej Soltysiak wrote:
> Hello David,
> 
> Wednesday, May 4, 2005, 9:48:36 PM, you wrote:
> > That seems to be the basic idea but there doesn't seem to be a provider
> > stack just yet, just a 'client' (though I could be wrong).  AOE is
> > similar in concept to iSCSI with the biggest difference being that AOE
> > runs over Ethernet and is thus non-routeable.  iSCSI operates over IP so
> > you can do all kinds of fun IP games with it.

The aoetools project at http://sourceforge.net/projects/aoetools/
includes the package vblade:

"This is a beta release of vblade, the virtual EtherDrive (R) blade.
The vblade is a program that makes a seekable file available over an
ethernet local area network (LAN) via the ATA over Ethernet (AoE)
protocol."

PS. This month's Linux Journal has an article about AoE.

Raf.

