Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTBLPnK>; Wed, 12 Feb 2003 10:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbTBLPnK>; Wed, 12 Feb 2003 10:43:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6917 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267365AbTBLPnJ>;
	Wed, 12 Feb 2003 10:43:09 -0500
Message-ID: <3E4A6DBD.8050004@pobox.com>
Date: Wed, 12 Feb 2003 10:52:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.60 cheerleading...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to counteract all the 2.5.60 bug reports...

After the akpm wave of compile fixes, I booted 2.5.60-BK on my Wal-Mart 
PC [via epia], and ran LTP on it, while also stressing it using 
fsx-linux in another window.  The LTP run showed a few minor failures, 
but overall 2.5.60-BK is surviving just fine, and with no corruption.

So, it's working great for me :)

