Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277006AbRJ3SB0>; Tue, 30 Oct 2001 13:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277047AbRJ3SBQ>; Tue, 30 Oct 2001 13:01:16 -0500
Received: from chaos.psimation.co.za ([160.124.112.123]:65041 "EHLO
	chaos.psimation.co.za") by vger.kernel.org with ESMTP
	id <S277006AbRJ3SBB>; Tue, 30 Oct 2001 13:01:01 -0500
Message-ID: <3BDEE870.1060104@psimation.com>
Date: Tue, 30 Oct 2001 19:50:40 +0200
From: "P.Agenbag" <internet@psimation.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.13 kernel and ext3???
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I just installed RedHat 7.2 with the 2.4.7 kernel. Low and behold, when 
I tried to install the latest kernels, I see that there are many options 
in the RedHat 2.4.7 kernel that are not even in the 2.4.13 kernel! How 
does this work? Also, I see many (EXPERIMENTAL) greyd-out areas in the 
kernel as well as other greyd out areas which are not experimental, yet 
won't allow me to select it ( reiserfs for example ) .
How can I get reiserfs to compile into the kernel, and to satsify my 
curiosity, how do you enable the experimental options?

Does it mean that if there is a fairly large difference between the 
RedHat 2.4.7 and the stock one from kernel.org, that they are not really 
the same? ie, does anyone foresee any future problems with redhat adding 
all these extra features to their kernel and people who would like to 
upgrade to a newer version ( for one, I selected ext3 during install, 
yet, now trying to install 2.4.13, I must revert back to ext2...)

Thanks


