Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbVKAPUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbVKAPUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVKAPUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:20:37 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:48033 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750856AbVKAPUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:20:36 -0500
Message-ID: <43678814.80407@tmr.com>
Date: Tue, 01 Nov 2005 10:21:56 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Dmitry Torokhov <dtor_core@ameritech.net>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel Badness 2.6.14-Git
References: <4362BFF1.3040304@linuxwireless.org>	 <200510312221.13217.dtor_core@ameritech.net>	 <20051101073530.GB27536@kroah.com>	 <200511010258.14313.dtor_core@ameritech.net>	 <20051101081433.GB28048@kroah.com> <1130854317.16163.52.camel@phantasy>
In-Reply-To: <1130854317.16163.52.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Tue, 2005-11-01 at 00:14 -0800, Greg KH wrote:
> 
> 
>>I don't have a problem with this, try it out and see what breaks :)
> 
> 
> I don't mind moving the driver (as Greg suggested earlier) if needed,
> but if Dmitry's idea to move input.o works, even better.

What about serio? Can that be used too early as well? Serial console?
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
