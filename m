Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268859AbUHLXBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268859AbUHLXBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268854AbUHLW6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:58:03 -0400
Received: from mail.tmr.com ([216.238.38.203]:41490 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268865AbUHLWya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:54:30 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Thu, 12 Aug 2004 18:58:08 -0400
Organization: TMR Associates, Inc
Message-ID: <cfgs3q$h6g$1@gatekeeper.tmr.com>
References: <200408101027.i7AARuZr012065@burner.fokus.fraunhofer.de><200408101027.i7AARuZr012065@burner.fokus.fraunhofer.de> <1092141996.4383.8119.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092350906 17616 192.168.12.100 (12 Aug 2004 22:48:26 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <1092141996.4383.8119.camel@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

> I haven't even stated which distribution I'm running. How can you
> possibly know what it puts into /etc/cdrecord.conf when it detects my
> CD-R? What relation has this to your man page?

David, I don't know what program you're running, but it is NOT cdrecord! 
There is no such file used in the program, and hasn't been in versions 
going back at least a year. I don't recall there ever being such a 
thing, and I've been using it since cdwrite was active. Any program 
which uses that file has NO relation to Joerg's man page, it's not his code.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
