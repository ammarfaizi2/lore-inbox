Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVKWXYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVKWXYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVKWXYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:24:21 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:20659 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932599AbVKWXYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:24:21 -0500
References: <200511232256.jANMuGg20547@unix-os.sc.intel.com>
Message-ID: <cone.1132788250.534735.25446.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <con@kolivas.org>
To: =?ISO-8859-1?B?Q2hlbiw=?= Kenneth W <kenneth.w.chen@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/rmap.c:491
Date: Thu, 24 Nov 2005 10:24:10 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W writes:

> Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.

> Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3

> Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3

                       ^^^^^^^^^^

Please try to reproduce it without proprietary binary modules linked in.

Con

