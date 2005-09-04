Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVIDEsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVIDEsj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 00:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVIDEsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 00:48:39 -0400
Received: from smtp.istop.com ([66.11.167.126]:31686 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751028AbVIDEsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 00:48:39 -0400
From: Daniel Phillips <phillips@istop.com>
To: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Date: Sun, 4 Sep 2005 00:51:10 -0400
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509040022.37102.phillips@istop.com> <20050904043000.GQ8684@ca-server1.us.oracle.com>
In-Reply-To: <20050904043000.GQ8684@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509040051.11095.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 September 2005 00:30, Joel Becker wrote:
> You asked why dlmfs can't go into sysfs, and I responded.

And you got me!  In the heat of the moment I overlooked the fact that you and 
Greg haven't agreed to the merge yet ;-)

Clearly, I ought to have asked why dlmfs can't be done by configfs.  It is the 
same paradigm: drive the kernel logic from user-initiated vfs methods.  You 
already have nearly all the right methods in nearly all the right places.

Regards,

Daniel




