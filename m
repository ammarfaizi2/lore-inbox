Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTGAQDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTGAQDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:03:32 -0400
Received: from post.pl ([212.85.96.51]:1796 "HELO matrix01b.home.net.pl")
	by vger.kernel.org with SMTP id S262610AbTGAQD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:03:28 -0400
Message-ID: <3F01B4AD.80503@post.pl>
Date: Tue, 01 Jul 2003 18:19:57 +0200
From: "Leonard Milcin Jr." <thervoy@post.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.org.au>
CC: rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <200306291445470220.01DC8D9F@smtp.comcast.net> <3EFF3FFA.60806@post.pl> <3EFF4177.6000705@post.pl> <200306291548060930.02159FEE@smtp.comcast.net> <20030701101509.GC3587@cancer> <3F01A0FE.6060403@post.pl> <20030701154133.GB3707@cancer>
In-Reply-To: <20030701154133.GB3707@cancer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stewart Smith wrote:
> This is exactly what has been said before in this thread
>  - i.e. mount the new FS over the old one (union style)
> and new writes go to the new FS.
> 
> I really thing LVM resizing automagick would be the way to go to.
> *much* cleaner and easier to implement.
> 
> The real useful thing to do would be to write a utility that would
> convert non-LVM systems to LVM.
> 

I said that too, some time ago. But don't know why it didn't reach LKML.
Perhaps my fault...

LVM resizing would be very good, because most of it is already coded.


-- 
"Unix IS user friendly... It's just selective about who its friends are."
                                                        -- Tollef Fog Heen

