Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVCIUBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVCIUBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVCIT7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:59:53 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:14607 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262375AbVCITs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:48:56 -0500
Date: Wed, 9 Mar 2005 20:48:53 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Christopher Rice <crice@virtc.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: p5ad2 motherboard sensors work
Message-Id: <20050309204853.738a3c1f.khali@linux-fr.org>
In-Reply-To: <4225F823.6010400@virtc.com>
References: <4225F823.6010400@virtc.com>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

> Your patch allows "finally" for me to be able to monitor all my temps
> in  my computer with an offset of 6. http://lkml.org/lkml/2005/2/26/65

Thanks for the report! I'm glad to learn that someone actually used my
w83627ehf driver :)

Can you elaborate of the "offset of 6"?

> Thanks very much let me know if you need any other information.

Did you only test temperatures or do you also have fan speed readings?

Thanks,
-- 
Jean Delvare
