Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWARNsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWARNsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWARNsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:48:45 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:36781 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030309AbWARNso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:48:44 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: NFS problem
To: Conio sandiago <coniodiago@gmail.com>,
       Conio sandiago <coniodiago@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 18 Jan 2006 14:55:09 +0100
References: <5wdAz-5a0-7@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EzDmI-0001X2-EH@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conio sandiago <coniodiago@gmail.com> wrote:

> i am having some problem in having root file system on NFS,
> i am developing a linux embedded system,. when i have a root file
> system on a NFS and i try to boot the kernel through a repeater hub ,
> then the kernel hangs at freeing init memory.
> 
>  if i connect the board with the PC through a cross cable,
> then the system works ok.

Can you mount nfs-shares from a desktop system through the repeater hub?
I guess, either the cable or the HUB is defective.

BTW: You should rather use a switch than a hub, especially for nfs.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
