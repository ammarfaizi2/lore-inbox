Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWIHSWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWIHSWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWIHSWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:22:40 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:34541 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1751095AbWIHSWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:22:24 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Uses for memory barriers
Date: Fri, 8 Sep 2006 20:22:40 +0200
User-Agent: KMail/1.8
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0609081401270.7953-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609081401270.7953-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609082022.41043.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I'm not sure what you mean.  The code wasn't intended to "work" in any 
> sense; it was just to make a point.  My question still stands: Is it 
> possible, in the code as I originally wrote it, for the assertion to fail?

Sorry, I misread || for &&.
The assertion will be true.

	Regards
		Oliver
