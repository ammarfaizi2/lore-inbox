Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbTFESNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 14:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbTFESNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 14:13:21 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:58631 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264786AbTFESNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 14:13:19 -0400
Subject: Re: capacity in 2.5.70-mm3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Julien Oster <lkml@mf.frodoid.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <frodoid.frodo.87y90g8lxm.fsf@usenet.frodoid.org>
References: <20030603181011$5b1a@gated-at.bofh.it>
	 <20030603192010$790e@gated-at.bofh.it>
	 <frodoid.frodo.87y90g8lxm.fsf@usenet.frodoid.org>
Content-Type: text/plain
Message-Id: <1054837610.590.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 05 Jun 2003 20:26:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 19:37, Julien Oster wrote:
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> writes:
> 
> Hello,
> 
> >> capacity  capacity  capacity  driver  identify  media  model  settings
> >> Multiplay capacity files. Funny :)
> 
> > Can reproduce it on my laptop with 2.5.70-mm3 and my server with
> > 2.5.70-bk8. Both have an ATAPI DVD attached to /dev/hdc.
> 
> Can also reproduce it on 2.4.21-rc1, on all my IDE devices: hda, hdc,
> hdg. The first two are harddrives, the last one's an ATAPI CD writer,
> so the device type doesn't seem to matter:

Seems fixed in 2.5.70-mm5... :-)

