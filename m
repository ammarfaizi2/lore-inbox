Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267515AbTAXDMr>; Thu, 23 Jan 2003 22:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267518AbTAXDMr>; Thu, 23 Jan 2003 22:12:47 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:9738 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S267515AbTAXDMp>;
	Thu, 23 Jan 2003 22:12:45 -0500
To: linux-kernel@vger.kernel.org
Cc: desrt <desrt@desrt.ca>
Subject: Re: ieee1394: Node 01:1023 has non-standard ROM format (0 quads), cannot parse
References: <1043372135.1442.7.camel@nothing.desrt.ca>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <1043372135.1442.7.camel@nothing.desrt.ca>
Date: 23 Jan 2003 22:21:42 -0500
Message-ID: <m3znpr6xmh.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "desrt" == desrt  <desrt@desrt.ca> writes:

desrt> Now, on attach/power on/modprobe ohci1394/etc I get this message:

desrt> ieee1394: Node 01:1023 has non-standard ROM format (0 quads), cannot parse

desrt> I get the same message with 2.4.20, .21-pre3, and 2.5.59.

I also see that error with 2.5.59 and an external maxtor drive that
works fine with 2.5.58 and revision 744 of the ieee1394 svn tree.

-JimC

