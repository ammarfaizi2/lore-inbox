Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWFRTeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWFRTeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 15:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWFRTeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 15:34:05 -0400
Received: from pat.uio.no ([129.240.10.4]:42714 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932307AbWFRTeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 15:34:04 -0400
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <181A24DA-7B74-4829-BB81-FFAF921DEE7D@usit.uio.no>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Greg KH <greg@kroah.com>
Content-Transfer-Encoding: 7bit
From: Hans A Eide <haeide@usit.uio.no>
Subject: Re: Sparse minor space in ub
Date: Sun, 18 Jun 2006 21:33:40 +0200
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.750)
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.333, required 12,
	autolearn=disabled, AWL 1.67, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jun 14, 2006 at 11:54:04PM -0700, Pete Zaitcev wrote:
 > I wrote a patch which allows to expand the number of partitions in ub
 > without breaking compatibility with the existing non-udev based
 > distributions.

FWIW, I can confirm this patch works with 2.6.17 and udev (Gentoo).
Sorry, no non-udev boxes around to test with.

Thanks!


HansA


