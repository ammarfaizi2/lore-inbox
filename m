Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269996AbUJHOmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269996AbUJHOmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269995AbUJHOmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:42:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51412 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269997AbUJHOll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:41:41 -0400
Date: Fri, 8 Oct 2004 16:43:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e100 not working with 2.6.9-rc3-mm3-vp-t3
Message-ID: <20041008144312.GA21291@elte.hu>
References: <20041008152044.2e92ea80.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008152044.2e92ea80.mdeboer@iua.upf.es>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Maarten de Boer <mdeboer@iua.upf.es> wrote:

> The e100 works correctly with (debian) kernel 2.6.7. I have not tried
> intermediate or partially patched (as in only rc3, only rc3-mm3)
> kernels.

please try -rc3-mm3 - i.e. is the breakage introduced by the -VP patch
or upstream? e100 works fine on a number of testboxes.

	Ingo
