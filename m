Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265149AbRGNXyq>; Sat, 14 Jul 2001 19:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265199AbRGNXyg>; Sat, 14 Jul 2001 19:54:36 -0400
Received: from ppp-167.96.triton.net ([216.65.167.96]:3968 "HELO
	tabris.domedata.com") by vger.kernel.org with SMTP
	id <S265149AbRGNXy0>; Sat, 14 Jul 2001 19:54:26 -0400
Message-ID: <3B50DBAE.7030406@lycosmail.com>
Date: Sat, 14 Jul 2001 19:54:22 -0400
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, reiser@namesys.com
Subject: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is a repost.

I am upgrading to a new 36GB HD, and intend to split it into 3 pieces: 
one 7GB vfat, one ~28GB linux data (reiser or ext2), and 1GB swap.

I need to know if I can trust ReiserFS, as I do believe that I do want 
ReiserFS.

