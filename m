Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265503AbTGKTRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbTGKS57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:57:59 -0400
Received: from APlessis-Bouchard-112-1-10-191.w81-248.abo.wanadoo.fr ([81.248.146.191]:23743
	"EHLO fozzy.syrius.org") by vger.kernel.org with ESMTP
	id S264888AbTGKSau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:30:50 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Linux 2.5.75 - still can't load aha152x (isapnp) => OOPS
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
	<wazza.87y8z5xre4.fsf@message.id>
	<20030711105358.00b125f0.akpm@osdl.org>
From: schmurtz@netcourrier.com
Date: Fri, 11 Jul 2003 20:45:30 +0200
In-Reply-To: <20030711105358.00b125f0.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 11 Jul 2003 10:53:58 -0700")
Message-ID: <wazza.87u19sykad.fsf@message.id>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I should have looked in linux-scsi.
Yes it does fix it.
Thank you.

-- 
S
