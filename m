Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVG0NAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVG0NAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 09:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVG0NAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 09:00:21 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:28860 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S262235AbVG0NAS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 09:00:18 -0400
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
Reply-To: bernd-schubert@gmx.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.3 network slowdown?
Date: Wed, 27 Jul 2005 15:00:11 +0200
User-Agent: KMail/1.7.2
Cc: Mihai Rusu <dizzy@roedu.net>, Howard Chu <hyc@highlandsun.com>
References: <1122452018.772579.63900@g49g2000cwa.googlegroups.com> <42E7497B.5040202@highlandsun.com> <20050727103036.GA14948@ahriman.roedu.net>
In-Reply-To: <20050727103036.GA14948@ahriman.roedu.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507271500.12187.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 July 2005 12:30, Mihai Rusu wrote:
> On Wed, Jul 27, 2005 at 01:44:43AM -0700, Howard Chu wrote:
> > I just recently compiled the 2.6.12.3 kernel for my x86_64 machine
> > (Asus A8V motherboard); was previously running a SuSE-compiled 2.6.8
> > kernel (SuSE 9.2 distro). I'm now seeing extremely slow throughput on
> > the onboard Yukon (Marvell) ethernet interface, but only in certain
> > conditions. Going back to the 2.6.8 kernel shows no slowdown.
>
> You might try the other SysKonnect driver as 2.6.12 ships with 2
> different drivers for this family of NICs.
>

No, AFAIK the rewritten driver is only in 2.6.13-rc or 2.6.12-mm (also already 
in previous -mm kernel versions).

Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
