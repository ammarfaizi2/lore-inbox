Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281177AbRKOXiB>; Thu, 15 Nov 2001 18:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281179AbRKOXhv>; Thu, 15 Nov 2001 18:37:51 -0500
Received: from pcow025o.blueyonder.co.uk ([195.188.53.125]:44304 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S281177AbRKOXhp>;
	Thu, 15 Nov 2001 18:37:45 -0500
Message-ID: <3BF45208.1010702@blueyonder.co.uk>
Date: Thu, 15 Nov 2001 23:38:48 +0000
From: Mr R A Mercer <r.a.mercer@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: loop back broken in 2.2.14
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Peddemors wrote:

 > Yes, I seriously considered the feasibility of having 2.4.14-fixed
 > kernels around, but I could just imagine trying to deal with millions of
 > people trying to download known good kernels on our bandwidth...

As has been mentioned before I think that the best way to avoid little
problems like this is to have a 2.4.x-rc1 kernel around for a day, if no
problems are found then that tree becomes 2.4.x if a problem is found
then is becomes 2.4.x-rc2 etc...

Cheers

Adam


