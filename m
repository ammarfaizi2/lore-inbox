Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVEWVA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVEWVA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 17:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVEWVA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 17:00:28 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:13326 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261963AbVEWVAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 17:00:19 -0400
Date: Mon, 23 May 2005 17:00:15 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Anil Kumar <anilsr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: kernel BUG at pageattr:107
Message-ID: <20050523210014.GC24089@tuxdriver.com>
Mail-Followup-To: Anil Kumar <anilsr@gmail.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <d3a6bba005052313382d7a81a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a6bba005052313382d7a81a4@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 01:38:05PM -0700, Anil Kumar wrote:

> I am getting the following error message as part of stack trace. 
> I have a system with > 4G mem with RHEL4 x86_64. I installed the OS
> and when I did the reboot, the system failed with a stack trace with
> errors as follows:
> 
> Intializing hardware.....
> kernel BUG at pageattr:107

Anil,

Please try the kernels here:

	http://people.redhat.com/linville/kernels/rhel4/

They contain a patch that I believe applies to your situation.
Please let me know the results of using those kernels.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
