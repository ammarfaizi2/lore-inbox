Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143380AbREKUIn>; Fri, 11 May 2001 16:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143378AbREKUIT>; Fri, 11 May 2001 16:08:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19469 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143385AbREKUHe>; Fri, 11 May 2001 16:07:34 -0400
Subject: Re: PROBLEM: 2.4.4ac7 oops, locks in init on boot
To: knghtbrd@debian.org (Joseph Carter)
Date: Fri, 11 May 2001 21:03:30 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010511130202.A8660@debian.org> from "Joseph Carter" at May 11, 2001 01:02:03 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yJ8M-0001c2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm considering it, but for AGP weirdness reasons.  Have the USB bugs been
> worked out?  I am highly dependant on USB.

Only one stepping of the AMD chip had the USB funnies. AMD released the info
needed to work around it and its now in the tree.

Alan

