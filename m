Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276420AbRJBSkk>; Tue, 2 Oct 2001 14:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276529AbRJBSka>; Tue, 2 Oct 2001 14:40:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58377 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276420AbRJBSkW>; Tue, 2 Oct 2001 14:40:22 -0400
Subject: Re: ext3 0.9.10 for Alan's tree
To: jalvo@mbay.net (John Alvord)
Date: Tue, 2 Oct 2001 19:45:16 +0100 (BST)
Cc: mfedyk@matchmail.com (Mike Fedyk), linux-kernel@vger.kernel.org
In-Reply-To: <562krt8uk7hml11k4741kuqlbsqa53hqbn@4ax.com> from "John Alvord" at Oct 02, 2001 11:36:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oUXc-0005Yc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >2.4.10-pre11 was only released ~1 week ago...
> >
> Wasn't there a big deal about having a common journalling service
> before other journalling systems jumped into the pool?

Yes. The ext3 code adds a framework for that. It just took too longer to
get in before 2.4.0. Whether reiser and others use it now is an open
question. It should for example be enough to do journalling VFAT however ;)

Alan
