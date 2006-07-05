Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWGENLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWGENLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWGENLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:11:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39080 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964841AbWGENLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:11:08 -0400
Date: Wed, 5 Jul 2006 18:42:19 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: "Ulrich Drepper" <drepper@gmail.com>
Cc: "Esben Nielsen" <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       tglx@linutronix.de
Subject: Re: Where can I get glibc with PI futex support (for -RT tests) ?
Message-ID: <20060705131219.GA4545@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <Pine.LNX.4.64.0607050133240.2448@localhost.localdomain> <a36005b50607041728h1442ebaapdd9d13b5d13fd3c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <a36005b50607041728h1442ebaapdd9d13b5d13fd3c4@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2006 at 05:28:30PM -0700, Ulrich Drepper wrote:
> On 7/4/06, Esben Nielsen <nielsen.esben@googlemail.com> wrote:
> >The answer is probably on the list, but I can't find it in the
> >archives..:-(
> 
> You have to wait your turn like everybody else.  Ingo/Thomas have one
> more bug to fix.  After that I'll check in the patches into the cvs
> archive.

Hi Ulrich,

I sent this mail earlier, for some reason it never made it to the list,
sorry if you received it more than once...

You probably have fixes for these problems, but this is the set of
glibc patches that I was using on top of your PI patch on Ingo's website

The attached tarball has 4 patches and a series file

        -Dinakar


--pf9I7BMVVzbSWLtt
Content-Type: application/x-tar-gz
Content-Disposition: attachment; filename="glibc-pi-fixes.tar.gz"
Content-Transfer-Encoding: base64

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

--pf9I7BMVVzbSWLtt--
