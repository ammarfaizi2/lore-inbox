Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUFQPMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUFQPMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUFQPMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:12:53 -0400
Received: from s158.mancelona.gtlakes.com ([64.68.227.158]:55194 "EHLO
	linux1.bmarsh.com") by vger.kernel.org with ESMTP id S266527AbUFQPMp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:12:45 -0400
From: Bruce Marshall <bmarsh@bmarsh.com>
Reply-To: bmarsh@bmarsh.com
To: linux-kernel@vger.kernel.org
Subject: Use of Moxa serial card with SMP kernels
Date: Thu, 17 Jun 2004 11:12:39 -0400
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406171112.39485.bmarsh@bmarsh.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moxa serial card option not available when requesting an SMP kernel  (2.6.7)

I was told back when 2.6.4 was new that the selection of a Moxa serial card 
was not possible if an SMP kernel was selected.  I used the work-around of 
not using an SMP kernel.

My question:   Is this a permanent problem which will never be fixed or a 
temporary situation?

Thanks.

-- 
+----------------------------------------------------------------------------+
+ Bruce S. Marshall  bmarsh@bmarsh.com  Bellaire, MI         06/17/04 11:08  +
+----------------------------------------------------------------------------+
"There is nothing so annoying as to have two people go right on talking
when you're interrupting."  --Mark Twain
