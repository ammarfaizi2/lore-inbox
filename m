Return-Path: <linux-kernel-owner+w=401wt.eu-S964959AbXAJRrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbXAJRrM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbXAJRrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:47:12 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:53840 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964959AbXAJRrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:47:12 -0500
Date: Wed, 10 Jan 2007 12:47:11 -0500
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Jeff Garzik <jeff@garzik.org>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash IDE chip under 2.6.18
Message-ID: <20070110174710.GL17267@csclub.uwaterloo.ca>
References: <45A3FF32.1030905@wolfmountaingroup.com> <45A4325C.9060902@garzik.org> <20070110143919.GH17269@csclub.uwaterloo.ca> <200701101829.32369.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701101829.32369.prakash@punnoor.de>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 06:29:28PM +0100, Prakash Punnoor wrote:
> You can install the Intel Matrix driver after "adjusting" the inf file...

Hmm, I guess a good question is: Why should I have to edit the inf file?
Is it an issue of them making it only install if your hardware is
already set to ahci mode?  But how am I supposed to boot and install the
driver until I have the driver installed then.  Well I might try that
next time I go there.  How stupid of intel.

--
Len Sorensen
