Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWJQRHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWJQRHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWJQRHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:07:51 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:62993 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751331AbWJQRHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:07:51 -0400
Message-ID: <45350DDF.10102@xs4all.nl>
Date: Tue, 17 Oct 2006 19:07:43 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 w/ GPS time source: worse performance
References: <4534F5F7.8020003@xs4all.nl> <1161103616.2919.70.camel@mindpipe>
In-Reply-To: <1161103616.2919.70.camel@mindpipe>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2006-10-17 at 17:25 +0200, Udo van den Heuvel wrote:
>> Hello,
>>
>> Why does a GPS as time source (with ntpd) perform so much worse with 2.6.18?
> 
> Um... you don't give nearly enough information to even begin to know
> what you're talking about.

?
Offset, error and jitter are higher. That's the performance.
I guess that users of a GPS as clock source understand.
