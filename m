Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbTBDTox>; Tue, 4 Feb 2003 14:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbTBDTox>; Tue, 4 Feb 2003 14:44:53 -0500
Received: from freeside.toyota.com ([63.87.74.7]:57041 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S267439AbTBDTov>; Tue, 4 Feb 2003 14:44:51 -0500
Message-ID: <3E401A6B.4000002@lexus.com>
Date: Tue, 04 Feb 2003 11:54:19 -0800
From: jjs <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not  2.4.x,
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Gale wrote:

>
> The ssh hang on exit "problem" is a policy of the ssh coders. It'll
> happen when you have a background job still running when you exit, which
> is still connected to the terminal.
>
> As I said, it's an ssh policy issue (which many people disagree with)
> and not a bug.
>
So, admin logs in and restarts a process -
a very very common task. oops, can't log out.

Sure sounds like a thinko to me, if not a bug.

Demoronized openssh packages for
suse and redhat are available by
popular request from:

ftp.mainphrame.com/pub/openssh

Joe

