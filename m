Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSCLXib>; Tue, 12 Mar 2002 18:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSCLXiM>; Tue, 12 Mar 2002 18:38:12 -0500
Received: from freeside.toyota.com ([63.87.74.7]:9235 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S290593AbSCLXiA>; Tue, 12 Mar 2002 18:38:00 -0500
Message-ID: <3C8E914F.1070701@lexus.com>
Date: Tue, 12 Mar 2002 15:37:51 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Shawn Starr <spstarr@sh0n.net>, Linux <linux-kernel@vger.kernel.org>
Subject: Re: uname reports 'unknown'
In-Reply-To: <15303.1015975366@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

>On 12 Mar 2002 17:59:53 -0500, 
>Shawn Starr <spstarr@sh0n.net> wrote:
>
>>Perhaps it should display P54C which is my P200 processor type?
>>
>
>Talk to sh-utils, uname -p is not kernel defined.
>
Yes the kernel part is fine, has been fine.

sh-utils comes with a broken uname, but the
patch is trivial - wonder when the vendors
will pick it up, it works fine here -

Linux uranium 2.4.19-pre2aa1 #1 Thu Mar 7 12:33:56 PST 2002 i686 
GenuineIntel

Joe



