Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288732AbSAICrC>; Tue, 8 Jan 2002 21:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288733AbSAICqw>; Tue, 8 Jan 2002 21:46:52 -0500
Received: from panther.fit.edu ([163.118.5.1]:2975 "EHLO fit.edu")
	by vger.kernel.org with ESMTP id <S288732AbSAICqj>;
	Tue, 8 Jan 2002 21:46:39 -0500
Message-ID: <3C3BB082.8020204@fit.edu>
Date: Tue, 08 Jan 2002 21:52:50 -0500
From: Kervin Pierre <kpierre@fit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020104
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fs corruption recovery?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I install and used 2.4.17 for about a week before my filesystem 
corrupted.  I've tried 'fsck -a' but it complains that there was no 
valid superblock found.

Are there any tools or techniques that will recover data from the 
corrupted filesystem even if there isn't a valid superblock?  Or is 
there a way to write a temporary superblock so I can access the 
information on the disk?

Lastly, if all else fails I'm going to try sending the drive one of 
those 'file recovery companies'.  Does anyone have a recommendation for 
a particular company?  I'm guessing that there'll be a few that wouldn't 
know what to do with a ext3 partition.

thanks,
-Kervin

