Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283581AbRLWEmV>; Sat, 22 Dec 2001 23:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283586AbRLWEmD>; Sat, 22 Dec 2001 23:42:03 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:10881 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S283581AbRLWElm>;
	Sat, 22 Dec 2001 23:41:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: dcinege@psychosis.com, Alexander Viro <viro@math.psu.edu>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sat, 22 Dec 2001 20:41:31 -0800
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu> <E16Hysa-0002kc-00@schizo.psychosis.com>
In-Reply-To: <E16Hysa-0002kc-00@schizo.psychosis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16I0S3-00019e-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 22, 2001 19:00, Dave Cinege wrote:
> Excellent! You've settled on using using an archiver format nobody uses,
Many file formats that require 'embedded' archives use cpio. RPM is one such 
file format. I think every single RPM distribution relying on cpio for the 
core of its package management system discounts your claim of 'nobody using 
it'. Just because you have not seen cpio directly used as an archive format 
doesn't mean it's unused.

> instead of the defacto standard that's already been implemented by
> atleast two people.
tar and cpio are both POSIX standards. I fail to see how one is more 
'defacto' than the other. 

As far as having tar already being implemented by at least two people, it 
really doesn't matter for a format as simple as cpio. Having a reference 
implementation for tar would be nice, as it is a hairy, complicated standard. 
The cpio format can be fully described in less than a page.

> G-E-N-I-U-S!
Grow up. Please.

-Ryan
