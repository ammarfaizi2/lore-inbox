Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319648AbSH3SlI>; Fri, 30 Aug 2002 14:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319647AbSH3SlI>; Fri, 30 Aug 2002 14:41:08 -0400
Received: from imo-d10.mx.aol.com ([205.188.157.42]:58306 "EHLO
	imo-d10.mx.aol.com") by vger.kernel.org with ESMTP
	id <S319648AbSH3SlE>; Fri, 30 Aug 2002 14:41:04 -0400
Message-ID: <3D6F85C4.3050807@netscape.net>
Date: Fri, 30 Aug 2002 14:48:36 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: greg@kroah.com, Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.32 port PnP BIOS to the driver model - ready for inclusion
References: <3D5D7E50.4030307@netscape.net> <20020817030604.GB7029@kroah.com> <3D5E595A.7090106@netscape.net> <20020817190324.GA9320@kroah.com> <3D5ECEFE.4020404@netscape.net> <20020818214745.GA19556@kroah.com> <3D6BF1E6.9010701@netscape.net> <20020828051406.GA26263@kroah.com> <3D6E85B1.4040708@netscape.net> <20020830052823.GE6486@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------060503020504040805040704"
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------060503020504040805040704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Now that all issues have been resolved and it has been tested, I feel 
that this patch is ready to be included in the official tree.  Thanks to 
Greg for pointing these issues out.  If one of you could please forward 
this to Linus, I'd greatly appreciate it.  Also could you please resend 
this with the patch inline because if I do netscape mail will remove all 
the tabs. :-)
Thanks,
Adam

--------------060503020504040805040704
Content-Type: application/octet-stream;
 name="pnpbios1-final.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pnpbios1-final.patch.gz"

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

--------------060503020504040805040704--
