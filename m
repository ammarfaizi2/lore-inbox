Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264888AbUD2QbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbUD2QbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbUD2QbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:31:19 -0400
Received: from pumpkin.explorerforum.com ([209.209.36.42]:55954 "EHLO
	explorerforum.com") by vger.kernel.org with ESMTP id S264888AbUD2QbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:31:18 -0400
Message-ID: <40912DD2.90900@lbl.gov>
Date: Thu, 29 Apr 2004 09:31:14 -0700
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neal Becker <ndbecker2@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: State of linux checkpointing?
References: <c6oorn$3dq$1@sea.gmane.org> <409012A4.9000502@pobox.com> <slrn-0.9.7.4-11992-4650-200404290913-tc@hexane.ssi.swin.edu.au> <c6plh7$sqj$1@sea.gmane.org>
In-Reply-To: <c6plh7$sqj$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neal Becker wrote:
> 
> I want checkpointing for:
> 
> 1) Protect against job interruption due to system crash, operator error,
> power loss, whatever
> 
> 2) Job mygration.  Even manual job mygration would be nice.
> 
> 

Two possible solutions:

1) http://ftg.lbl.gov/checkpoint

and 

2) http://www.meiosys.com

thomas

