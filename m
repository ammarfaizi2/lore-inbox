Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSITSQS>; Fri, 20 Sep 2002 14:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbSITSQR>; Fri, 20 Sep 2002 14:16:17 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:13067 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S263246AbSITSQR>; Fri, 20 Sep 2002 14:16:17 -0400
Message-ID: <3D8B6722.8050707@namesys.com>
Date: Fri, 20 Sep 2002 22:21:22 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: locking rules for ->dirty_inode()
References: <3D8B4421.59392B30@digeo.com>	<15755.19895.544309.44729@laputa.namesys.com>	<3D8B5111.A318D63D@digeo.com> <15755.23491.712588.305582@laputa.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might ask the SGI guys what they do.  I know that they have a 
systematic approach to documenting lock ordering.

Hans


