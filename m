Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbTDQQ3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 12:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbTDQQ3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 12:29:25 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:22290 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261339AbTDQQ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 12:29:24 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Balram Adlakha <b_adlakha@softhome.net>
Subject: Re: bt848?
Date: Thu, 17 Apr 2003 18:41:05 +0200
User-Agent: KMail/1.5
References: <200304172152.59580.b_adlakha@softhome.net>
In-Reply-To: <200304172152.59580.b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304171841.05790.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 April 2003 23:52, Balram Adlakha wrote:
> where is the bt818 capture card module??? don't see it anywhere in the
> config...

On 2.4.20 it's CONFIG_VIDEO_BT848.

-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

