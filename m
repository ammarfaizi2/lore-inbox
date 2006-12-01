Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759303AbWLAOdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759303AbWLAOdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758851AbWLAOdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:33:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52107 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1759303AbWLAOdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:33:05 -0500
Date: Fri, 1 Dec 2006 06:32:25 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Weinehall <tao@acc.umu.se>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: mass-storage problems with Archos AV500
Message-Id: <20061201063225.64122205.zaitcev@redhat.com>
In-Reply-To: <20061129214736.GU14886@vasa.acc.umu.se>
References: <20061129214736.GU14886@vasa.acc.umu.se>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 22:47:36 +0100, David Weinehall <tao@acc.umu.se> wrote:

> I've got an Archos AV500 here (running the very latest firmware), pretty
> much acting as a doorstop, since I cannot get it to be recognized
> properly by Linux.
>[...]
> [  118.144000] SCSI device sdb: 58074975 512-byte hdwr sectors (29734
> MB)
> [  118.144000] sdb: Write Protect is off
> [  118.144000] sdb: Mode Sense: 33 00 00 00
> [  118.144000] sdb: assuming drive cache: write through
> [  118.144000]  sdb: unknown partition table
> [  118.452000] sd 4:0:0:0: Attached scsi removable disk sdb

It seems to be working just fine. What does parted say about it?

-- Pete
