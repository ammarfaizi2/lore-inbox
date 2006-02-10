Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWBJANR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWBJANR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWBJANR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:13:17 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:29962 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750855AbWBJANQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:13:16 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Dave Spring <dspring@acm.org>
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
Date: Fri, 10 Feb 2006 00:13:15 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Ken MacFerrin <lists@macferrin.com>
References: <43E0FC55.6080503@acm.org> <43EBD67E.9020308@acm.org>
In-Reply-To: <43EBD67E.9020308@acm.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602100013.15276.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 23:55, Dave Spring wrote:
> Just for closure's sake:
>  This turned out to be a hardware problem.
> Memtest86+ http://www.memtest.org/ found an intermittent and
> pattern-sensitive memory error,
> and only appearing at one or two random locations within the 256M module.
> Replacing the dodgy RAM module did the trick.

Thanks Dave. Any update on your problem Ken? I'm keen to hear whether you had 
crashes without the NVIDIA driver loaded.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
