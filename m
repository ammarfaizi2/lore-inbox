Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbTGGJuv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 05:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266942AbTGGJuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 05:50:51 -0400
Received: from mail.ithnet.com ([217.64.64.8]:39181 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264862AbTGGJuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 05:50:50 -0400
Date: Mon, 7 Jul 2003 12:06:16 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030707120616.5b9b5285.skraw@ithnet.com>
In-Reply-To: <1057515223.20904.1315.camel@tiny.suse.com>
References: <20030706183453.74fbfaf2.skraw@ithnet.com>
	<1057515223.20904.1315.camel@tiny.suse.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

I have to correct myself regarding the problem. It does _not_ arise on
aic-driven scsi-disk, but on 3ware-driven RAID5 with 320 GB data. I tried to
mount it by hand, but that does not work either. It does not look like there is
a lot of work going on on the hds while mounting (no LEDs). 
Can anyone reproduce with equal setup?
I try to come up with further information...
-- 
Regards,
Stephan
