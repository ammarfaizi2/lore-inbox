Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290333AbSBVJla>; Fri, 22 Feb 2002 04:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289764AbSBVJlT>; Fri, 22 Feb 2002 04:41:19 -0500
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:26523
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S290333AbSBVJlO>; Fri, 22 Feb 2002 04:41:14 -0500
Message-ID: <3C76124D.50505@st-peter.stw.uni-erlangen.de>
Date: Fri, 22 Feb 2002 10:41:33 +0100
From: svetljo <galia@st-peter.stw.uni-erlangen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: linux-2.5.5-dj1 + xfs-cvs --- kernel bug at elevator.c : 237!
In-Reply-To: <3C7607A7.2020804@st-peter.stw.uni-erlangen.de> <20020222090453.GI1427@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *16eCCP-00054R-00*KJS843Qu.5c* (Studentenwohnanlage Nuernberg St.-Peter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>i tried to get patch-2.5.5dj1 in linux-2.5.5-xfs-cvs
>>but thats what i got
>>#####################################
>>Activating swap partitions:        OK
>>Finding modules dependancies:  OK
>>Kernel Bug at elevator.c : 237!
>>Invalid operand: 0000
>>
>
>known problem, disable ide floppy support for now.
>
thanks that fixed it
i have to only figure it out , how to get  keyboard(PS2) and mices(PS2 
and USB) working

