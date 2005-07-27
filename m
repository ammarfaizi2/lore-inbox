Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVG0WCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVG0WCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVG0WAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:00:10 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:58846 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261169AbVG0V67 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:58:59 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc3-mm2/mm1 breaks DRI
Date: Wed, 27 Jul 2005 17:58:52 -0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@gmail.com>
References: <20050727024330.78ee32c2.akpm@osdl.org>
In-Reply-To: <20050727024330.78ee32c2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507271758.52466.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >>
>> >> I also use 2.6.13-rc3-mm1.  Will try with a previous version an report to lkml if
>> >> it works.
>> >>
>> >
>> > I just tried 13-rc2-mm1 and dri is working again. Its reported to also work
>> > with 13-rc3.
>> 
>
>Hmm no idea what could have broken it, I'm at OLS and don't have any
>DRI capable machine here yet.. so it'll be a while before I get to
>take a look at it .. I wouldn't be terribly surprised if some of the
>new mapping code might have some issues..

Still happens with mm2.

Thanks
Ed

