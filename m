Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTDQSio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTDQSio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:38:44 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:31493 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261294AbTDQSin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:38:43 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Balram Adlakha <b_adlakha@softhome.net>
Subject: Re: bt848?
Date: Thu, 17 Apr 2003 20:50:31 +0200
User-Agent: KMail/1.5
References: <200304172152.59580.b_adlakha@softhome.net> <200304171841.05790.fsdeveloper@yahoo.de> <200304180000.14416.b_adlakha@softhome.net>
In-Reply-To: <200304180000.14416.b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304172050.32031.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 April 2003 02:00, Balram Adlakha wrote:
> On Thursday 17 Apr 2003 4:41 pm, you wrote:
> > On Thursday 17 April 2003 23:52, Balram Adlakha wrote:
> > > where is the bt818 capture card module??? don't see it anywhere in the
> > > config...
> >
> > On 2.4.20 it's CONFIG_VIDEO_BT848.
>
> no in the 2.5 kernels. Has it been removed?

No, there it's also CONFIG_VIDEO_BT848.

-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

