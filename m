Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270809AbTHAQI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 12:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbTHAQI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 12:08:57 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:60114
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270809AbTHAQI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 12:08:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Stephen Anthony <stephena@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: What's the timeslice size for kernel 2.6.0-test2, IA32?
Date: Sat, 2 Aug 2003 02:13:49 +1000
User-Agent: KMail/1.5.2
References: <200308011321.45183.stephena@users.sourceforge.net>
In-Reply-To: <200308011321.45183.stephena@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308020213.49248.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Aug 2003 01:51, Stephen Anthony wrote:
> I haven't been able to find this information anywhere.  I know HZ was
> increased to 1000, but was the timeslice decreased to 1 ms (from 10 ms)
> as well?

Depends on nice of the task. Nice 0 tasks get 102ms.

Con

