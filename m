Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbUJ0CVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUJ0CVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbUJ0CVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:21:16 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:49384 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261575AbUJ0CVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:21:07 -0400
Date: Tue, 26 Oct 2004 22:17:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Let's make a small change to the process
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Randy Dunlap <rddunlap@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200410262220_MC3-1-8D36-77F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 at 22:44:21 +0200 Paolo Ciarrocchi wrote:
>
>> 2.6-ac seems to be filling this role right now.
>> 
>
> If the goal of -ac is to only include those fixes, why can't we rename
> it in something more "intuitive" for the final users ?
> Do you see what I mean ?

  AFAICT -ac is not supposed to be a complete collection of bugfixes.

  2.6.9-ac3 was certainly missing a lot of them (haven't seen -ac4 yet.)


--Chuck Ebbert  26-Oct-04  20:33:14
