Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289469AbSAJOjE>; Thu, 10 Jan 2002 09:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289468AbSAJOiz>; Thu, 10 Jan 2002 09:38:55 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:6786 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S289463AbSAJOij>;
	Thu, 10 Jan 2002 09:38:39 -0500
Message-ID: <3C3DA7E0.3050106@acm.org>
Date: Thu, 10 Jan 2002 08:40:32 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Thomas Capricelli <tcaprice@logatique.fr>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it
In-Reply-To: <24675.1010641200@kao2.melbourne.sgi.com> <20020110105313.3ED7023CBB@persephone.dmz.logatique.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll do it, since I already have most of it, unless Keith already has or 
wants to.

-Corey

Thomas Capricelli wrote:

>On Thursday 10 January 2002 06:40, Keith Owens wrote:
>
>>On Wed, 09 Jan 2002 23:13:28 -0600,
>>
>>Corey Minyard <minyard@acm.org> wrote:
>>
>>>Hmm.  It worked fine for me.  I made it a module, and it put it into
>>>kernel/lib in
>>>/lib/modules/2.4.17 and it did not put it in lib/lib.a  I make it a
>>>non-module, and
>>>it gets included in lib/lib.a. My diff was the same as yours for the
>>>Makefile.
>>>
>>Worked for me this time as well.  I had a typo the first time then did
>>an ugly fix to a non-existent problem :(
>>
>
>
>	Could you give a patch for all of this ? either Keith or Corey ?
>
>
>Thomas
>



