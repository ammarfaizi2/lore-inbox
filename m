Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275669AbRIZWjm>; Wed, 26 Sep 2001 18:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275671AbRIZWjc>; Wed, 26 Sep 2001 18:39:32 -0400
Received: from tux.cs.ou.edu ([129.15.78.244]:25613 "EHLO tux.cs.ou.edu")
	by vger.kernel.org with ESMTP id <S275669AbRIZWjW>;
	Wed, 26 Sep 2001 18:39:22 -0400
Date: Wed, 26 Sep 2001 17:41:16 -0400
From: Robert Cantu <robert@tux.cs.ou.edu>
To: linux-kernel@vger.kernel.org
Subject: Question: Etherenet Link Detection
Message-ID: <20010926174116.A7544@tux.cs.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a method of detecting the link status of an ethernet NIC? If not,
is it feasible? And if it is, then would it be something in each driver,  
or on a level above the driver, thereby available to all drivers? I figure
the list is the best place to ask this, although it might be a moot point.
                                                                
Example: Have a cable modem hooked into a computer's NIC. Cable service   
goes out, link light on back of NIC goes out. A hypothetical program says 
that the link is gone via some hook in /proc somewhere.

Is this a worthwhile endeavor, if possible?

Thanks in advance,
Robert

