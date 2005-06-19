Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVFSRuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVFSRuy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 13:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVFSRuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 13:50:54 -0400
Received: from fsmlabs.com ([168.103.115.128]:65488 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262266AbVFSRtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 13:49:51 -0400
Date: Sun, 19 Jun 2005 11:53:24 -0600 (MDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dipankar@in.ibm.com,
       ak@suse.de, akpm@osdl.org, maneesh@in.ibm.com
Subject: Re: [RFC,PATCH] RCU: clean up a few remaining synchronize_kernel()
 calls
In-Reply-To: <20050618002021.GA2892@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com>
References: <20050618002021.GA2892@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2005, Paul E. McKenney wrote:

> Please let me know if there are any problems with any of these changes.

Hi Paul,
	Do you have any pending patches to update Documentation/RCU/* too? 
The best i can find explaining usage is from;

http://lwn.net/Articles/130341/

Thanks,
	Zwane

