Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265780AbSKAUuy>; Fri, 1 Nov 2002 15:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265781AbSKAUuy>; Fri, 1 Nov 2002 15:50:54 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:19208 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265780AbSKAUux>; Fri, 1 Nov 2002 15:50:53 -0500
Message-ID: <3DC2EA6D.1070200@namesys.com>
Date: Fri, 01 Nov 2002 23:56:13 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: Nikita Danilov <Nikita@Namesys.COM>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: reiser4 [0/8] overview
References: <200210311910.48774.m.c.p@wolk-project.de> <15809.29694.883782.811063@laputa.namesys.com> <200210311931.08347.m.c.p@wolk-project.de>
In-Reply-To: <200210311910.48774.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:

>Does not occur with ReiserFS 3 from 2.5.45 nor with any other FS doing those 
>small stress test. My personal impression is that Reiser4 is slower than 3 but 
>that might be because of above debugging.
>
>I hope this helps.
>
>ciao, Marc
>
>
>  
>
Please give us a script which is slower than v3 for us to reproduce 
with, and we will start analyzing it.

-- 
Hans


