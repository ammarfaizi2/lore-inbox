Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264942AbUD2Tup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbUD2Tup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 15:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbUD2Tup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 15:50:45 -0400
Received: from main.gmane.org ([80.91.224.249]:41179 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264942AbUD2Tun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 15:50:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Neal D. Becker" <ndbecker2@verizon.net>
Subject: Re:  State of linux checkpointing?
Date: Thu, 29 Apr 2004 15:50:38 -0400
Message-ID: <c6rmae$ejq$2@sea.gmane.org>
References: <c6oorn$3dq$1@sea.gmane.org> <409012A4.9000502@pobox.com> <slrn-0.9.7.4-11992-4650-200404290913-tc@hexane.ssi.swin.edu.au> <c6plh7$sqj$1@sea.gmane.org> <40912DD2.90900@lbl.gov> <slrn-0.9.7.4-18380-21584-200404300311-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 139.85.94.36
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors wrote:

> Thomas Davis <tadavis@lbl.gov> said on Thu, 29 Apr 2004 09:31:14 -0700:
>> Neal Becker wrote:
>> > 
>> > I want checkpointing for:
>> > 
>> > 1) Protect against job interruption due to system crash, operator
>> > error, power loss, whatever
>> > 
>> > 2) Job mygration.  Even manual job mygration would be nice.
>> 
>> Two possible solutions:
>> 
>> 1) http://ftg.lbl.gov/checkpoint
> 
> Oooh. Shiny.
> 

Looks interesting.  Kernel-2.4 only AFAICT.


