Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270633AbTGZXtF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 19:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270636AbTGZXtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 19:49:05 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:12428
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270633AbTGZXtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 19:49:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O9int for interactivity
Date: Sun, 27 Jul 2003 10:08:22 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <200307270306.47363.kernel@kolivas.org> <1059243458.575.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1059243458.575.1.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271008.22384.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 04:17, Felipe Alfaro Solana wrote:
> On Sat, 2003-07-26 at 19:06, Con Kolivas wrote:
> > Patch applies on top of 2.6.0-test1-mm2 + O8int. A patch against vanilla
> > 2.6.0-test1 is also available on my website.
>
> patch-test1-O9 contains some differences with respect to patch-O9 for
> the -mm kernels. In the patch-test1-O9, MAX_SLEEP_AVG and
> STARVATION_LIMIT are both set to (10*HZ), while in patch-O9-mm2 they are
> set to (HZ).
>
> Is this intentional?

No, my bad. Will post a fix on my site soon.

Con

