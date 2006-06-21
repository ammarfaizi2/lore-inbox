Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWFUUIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWFUUIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWFUUIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:08:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8642 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030217AbWFUUIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:08:20 -0400
Date: Wed, 21 Jun 2006 13:08:02 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: andi@lisas.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: USB/hal: USB open() broken? (USB CD burner underruns, USB HDD
 hard resets)
Message-Id: <20060621130802.004ef1eb.zaitcev@redhat.com>
In-Reply-To: <20060621164425.GB22736@rhlx01.fht-esslingen.de>
References: <20060621093348.GA13143@rhlx01.fht-esslingen.de>
	<Pine.LNX.4.44L0.0606211158030.6700-100000@iolanthe.rowland.org>
	<20060621164425.GB22736@rhlx01.fht-esslingen.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 18:44:25 +0200, Andreas Mohr <andim2@users.sourceforge.net> wrote:

> I'll try to verify this by simply removing all ALLOW_MEDIUM_REMOVAL calls ;)

Try to burn with ub. It does not implement door locking.

-- Pete
