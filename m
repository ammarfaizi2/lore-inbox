Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUETWZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUETWZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUETWZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:25:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:35738 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265196AbUETWZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:25:18 -0400
Date: Fri, 21 May 2004 00:21:20 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Gopikrishnan Sidhardhan <gs33@eng.buffalo.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Data loss on IDE drive after crash
Message-ID: <20040521002120.C2172@electric-eye.fr.zoreil.com>
References: <40AD0365.6040003@eng.buffalo.edu> <1085081357.2044.1.camel@cassius.public.buffalo.edu> <20040520233312.B2172@electric-eye.fr.zoreil.com> <40AD28E0.2080705@eng.buffalo.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40AD28E0.2080705@eng.buffalo.edu>; from gs33@eng.buffalo.edu on Thu, May 20, 2004 at 05:53:36PM -0400
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gopikrishnan Sidhardhan <gs33@eng.buffalo.edu> :
[...]
> Is it?  The file has totally disppeared.  Isn't it because the inode has 
> been marked as belonging to a deleted file?

The machine crashed. The deleted part disappeared. The new part has not
appeared. No unexpected behavior so far.

--
Ueimor
