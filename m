Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbQKPRmJ>; Thu, 16 Nov 2000 12:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbQKPRl6>; Thu, 16 Nov 2000 12:41:58 -0500
Received: from cs.utexas.edu ([128.83.139.9]:32398 "EHLO cs.utexas.edu")
	by vger.kernel.org with ESMTP id <S131138AbQKPRlq>;
	Thu, 16 Nov 2000 12:41:46 -0500
Date: Thu, 16 Nov 2000 11:11:45 -0600 (CST)
From: Nishant Rao <nishant@cs.utexas.edu>
To: linux-kernel@vger.kernel.org
Subject: Setting IP Options in the IP-Header 
Message-ID: <Pine.LNX.4.21.0011161111210.5572-100000@crom.cs.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are conducting some research that involves setting our custom data as
a new IP option in the IP header (in the options field) of every packet.

We have poured over the source code but it is quite confusing to figure
out how the details of the way the options field is split among various
options (ie. offsets etc). Can anyone help us figure out how to add new
custom options into the IP header ? 

Please CC me on your replies so that I can also get the answer :
<nishant@cs.utexas.edu> 

Thanks,
Nishant


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
