Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTKNUDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTKNUDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:03:03 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:518 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262709AbTKNUDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:03:01 -0500
To: gene.heskett@verizon.net
Cc: "Patrick Beard" <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 VFAT problem
References: <20031114113224.GR21265@home.bofhlet.net>
	<200311140945.36537.gene.heskett@verizon.net>
	<87u156rghz.fsf@devron.myhome.or.jp>
	<200311141351.18944.gene.heskett@verizon.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 15 Nov 2003 05:02:41 +0900
In-Reply-To: <200311141351.18944.gene.heskett@verizon.net>
Message-ID: <87ptfura5a.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> dd if=/dev/sda1|md5sum <--note use of the same device as to read pix.
> has been running for 3 or so minutes now, steadily reading the camera.  
> I shoulda put a time in front of it!  Ok got it, heres the sum:
> 127945+0 records in
> 127945+0 records out
> f6c568dd1f35bb37f3d667a2ab228e2f
> f6c568dd1f35bb37f3d667a2ab228e2f
[...]
> What does this tell us?

Thanks. I want to know it's not reading the randomly garbage.
Can this problem reproduce easy? If so, what operations?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
