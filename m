Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTEFEqC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTEFEqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:46:02 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:4 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S262364AbTEFEqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:46:01 -0400
Date: Tue, 6 May 2003 06:58:22 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: crypt@ihug.co.nz
Cc: linux-kernel@vger.kernel.org
Subject: Re: status of matrox framebuffer drivers.
Message-ID: <20030506045822.GD5326@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030506023653.GA23098@python.graveyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506023653.GA23098@python.graveyard>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: crypt@ihug.co.nz <crypt@ihug.co.nz>
Date: Tue, May 06, 2003 at 02:36:54PM +1200
> Hi I was just wondering if there was any work being done to get the
> matrox framebuffer drivers updated so that they would compile under the
> 4.5 series kernels.
> 
> They seem to have been broken for a long time.
> 
If you read this list you might notice that Petr Vandovec is hard at
work, and a patch for 2.5.69 is available, as was one for 2.5.68, for
2.5.67, etc etc.

ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/

The patch for 2.5.69 is 2.5.68-c1248, but it applies without
difficulties.

HTH,
Jurriaan
-- 
And I thought that the Borg were bad...
Debian (Unstable) GNU/Linux 2.5.69 4112 bogomips load av: 0.51 0.34 0.31
