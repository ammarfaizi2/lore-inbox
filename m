Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932716AbVISWcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbVISWcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbVISWcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:32:16 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:44691 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932716AbVISWcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:32:16 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: PWC 10.x driver in the kernel?
Date: Mon, 19 Sep 2005 23:32:45 +0100
User-Agent: KMail/1.8.90
Cc: linux-kernel@vger.kernel.org, Luc Saillard <luc@saillard.org>
References: <dgn8vo$oli$1@sea.gmane.org>
In-Reply-To: <dgn8vo$oli$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509192332.45445.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 September 2005 22:01, Joshua Kwan wrote:
> Hi,
>
> I've just acquired a Logitech webcam and I couldn't get it to work with
> the version of the PWC driver currently in the kernel. Given all the
> contention about PWCX etc., are there plans to merge in the new 10.x
> version of the driver available at http://www.saillard.org/linux/pwc/?
> (This version does work with my webcam.) Just like the one in the kernel
> tree right now, this version does not require pwcx at all (the binary
> blob was reverse-engineered), so I think it's a big improvement.
>

Even if the reverse engineered component was deemed unacceptable, I'd like to 
see the (other) differences between the two drivers merged ASAP. AFAIK, the 
10.x pwc driver supports the v4l2 API which is useful, and as you mentioned 
actually works on more camera (the 9.x versions just spam errors to dmesg on 
my PWC740K).

Luc? (added CC)

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
