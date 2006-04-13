Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWDMCK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWDMCK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 22:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWDMCK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 22:10:27 -0400
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:57874 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932426AbWDMCK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 22:10:26 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Dan Bonachea <bonachead@comcast.net>
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
Date: Thu, 13 Apr 2006 03:10:27 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
In-Reply-To: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604130310.27560.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 02:45, Dan Bonachea wrote:
> Hi - I believe I've discovered a thread-safety bug in the Linux 2.6.x
> kernel implementation of write(2).

Hi, let's get the obvious out of the way first.

Is this reproducible on a current -stable, non-vendor kernel?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
