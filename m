Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSJaWHL>; Thu, 31 Oct 2002 17:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbSJaWGj>; Thu, 31 Oct 2002 17:06:39 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:27080 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265389AbSJaWE7>;
	Thu, 31 Oct 2002 17:04:59 -0500
Subject: Re: Reiser vs EXT3
From: "David C. Hansen" <haveblue@us.ibm.com>
To: Hans Reiser <reiser@namesys.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3DC1A5D5.8000901@namesys.com>
References: <Pine.LNX.4.44.0210311248030.25405-100000@dlang.diginsite.com> 
	<3DC1A5D5.8000901@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 14:10:10 -0800
Message-Id: <1036102211.4272.276.camel@nighthawk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 13:51, Hans Reiser wrote:
> If you want to talk about 2.6 then you should talk about reiser4 not 
> reiserfs v3, and reiser4 is 7.6 times the write performance of ext3 for 
> 30 copies of the linux kernel source code using modern IDE drives and 
> modern processors on a dual-CPU box, so I don't think any amount of 
> improved scalability will make ext3 competitive with reiser4 for 
> performance usages.  
> 
> We haven't had anyone test performance using RAID yet for reiser4, that 
> could be fun.

I have a 14-drive hardware RAID array on an 8-proc box.  Is that the
kind of thing you want testing on?  If you want to send me some testing
scripts, I'll run them.  

-- 
Dave Hansen
haveblue@us.ibm.com

