Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266535AbUFWOEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUFWOEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUFWOEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:04:08 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:47664 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266535AbUFWOEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:04:05 -0400
Subject: Re: Why dentry->d_qstr change in 2.6.7 ?
From: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.auc.dk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1087660293.30405.47.camel@localhost>
References: <1087660293.30405.47.camel@localhost>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1087999469.10863.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Jun 2004 16:04:29 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can it really be, that noone knows why this change has been made !??

On Sat, 2004-06-19 at 17:51, Kristian Sørensen wrote:
> Hi!
> 
> Anyone know why the dentry->d_qstr in linux-2.6.7 has changed to
> dentry->d_name? (structure dentry defined in include/linux/dcache.h)
> 
> 
> Cheers, KS.
-- 
Kristian Sørensen <ks@cs.auc.dk>

