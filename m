Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTEQCeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 22:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTEQCeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 22:34:03 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:64175 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261168AbTEQCeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 22:34:02 -0400
Date: Fri, 16 May 2003 22:44:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: help...where is my memory going? --soln found...sysv
  shared mem
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305162246_MC3-1-3949-E344@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Some of the stuff that had already started up was using sysv shared memory 
> segments, and they didn't get cleaned up properly.  Accounts for all the memory 
> usage that I was trying to figure out.


  ...and this gets accounted for as cached?
