Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270799AbRHNUQx>; Tue, 14 Aug 2001 16:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270798AbRHNUQn>; Tue, 14 Aug 2001 16:16:43 -0400
Received: from roc-24-95-218-9.rochester.rr.com ([24.95.218.9]:52873 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S270784AbRHNUQc>; Tue, 14 Aug 2001 16:16:32 -0400
Date: Tue, 14 Aug 2001 10:24:44 -0400
From: Chris Mason <mason@suse.com>
To: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: re: Performance 2.4.8 is worse than 2.4.x<8 (SPEC NFS results sho w
 this)
Message-ID: <22920000.997799084@tiny>
In-Reply-To: <F341E03C8ED6D311805E00902761278C04728E71@xfc04.fc.hp.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, August 13, 2001 09:40:59 AM -0700 "HABBINGA,ERIK
(HP-Loveland,ex1)" <erik_habbinga@hp.com> wrote:

> Here are some SPEC SFS NFS testing (http://www.spec.org/osg/sfs97) results
> I've been doing over the past few weeks that shows NFS performance
> degrading since the 2.4.5pre1 kernel.  I've kept the hardware constant,
> only changing the kernel. 

Did the 2.4.5pre1 have the transaction tracking patch?

-chris

