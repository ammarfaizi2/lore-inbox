Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268401AbUIBTdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268401AbUIBTdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUIBTdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:33:03 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:5052 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S268401AbUIBTcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:32:03 -0400
To: Thomas Davis <tadavis@lbl.gov>
Cc: Stuart Young <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: Re: 2.6.9-rc1 : Weirdness after shutdown - ACPI or Suspend bug?
References: <200409012020.42482.cef-lkml@optusnet.com.au>
	<200409012352.21576.cef-lkml@optusnet.com.au>
	<41363D89.2070604@lbl.gov>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Thu, 02 Sep 2004 12:30:56 -0700
In-Reply-To: <41363D89.2070604@lbl.gov> (message from Thomas Davis on Wed,
 01 Sep 2004 14:22:17 -0700)
Message-ID: <877jrcv573.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Davis <tadavis@lbl.gov> writes:

> HOWEVER, using swsusp2, hibernating the machine works, but it
> refuses to wake back up until you pull the AC power and battery out.

on my thinkpad t40 after suspending to ram the machine wakes up but
then it shuts off. shutdown works fine though.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
