Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVCRQE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVCRQE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVCRQCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:02:08 -0500
Received: from smtpout17.mailhost.ntl.com ([212.250.162.17]:5787 "EHLO
	mta09-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261675AbVCRQAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:00:17 -0500
Subject: Re: 2.6.11 breaks modules gratuitously
From: Ian Campbell <ijc@hellion.org.uk>
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87fyythsty.fsf@stark.xeocode.com>
References: <87fyythsty.fsf@stark.xeocode.com>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 16:00:09 +0000
Message-Id: <1111161609.15795.32.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-18 at 10:33 -0500, Greg Stark wrote:

> In particular vmware used skb_copy_datagram. So 2.6.11 broke vmware for no
> good reason.

I don't know about the validity or otherwise of (un)exporting
skb_copy_datagram but for what it's worth
http://ftp.cvut.cz/vmware/vmware-any-any-update89.tar.gz has been
updated to work with 2.6.11.

Ian.

-- 
Ian Campbell
Current Noise: Entombed - Out of Heaven

Santa Claus is watching!

