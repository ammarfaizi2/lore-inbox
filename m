Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265484AbUEZL2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265484AbUEZL2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265486AbUEZL2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:28:18 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:12401 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265484AbUEZL2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:28:17 -0400
Message-ID: <40B47F47.20504@yahoo.com.au>
Date: Wed, 26 May 2004 21:28:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: mingo@elte.hu, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc1-bk: SMT scheduler bug / crashes on kernel boot
References: <1085568719.2666.53.camel@imp.csi.cam.ac.uk> <1085569838.2666.60.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1085569838.2666.60.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

>The kernel shows a warning about the number of siblings being 2 but only
>1 being detected.  Perhaps this is the cause of the problem.  Even if

Probably this is the cause of the problem.

What is the exact message?
