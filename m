Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271187AbTGPWlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271188AbTGPWlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:41:08 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:64999 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S271187AbTGPWlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:41:07 -0400
Message-ID: <3F15DB28.9000709@genebrew.com>
Date: Wed, 16 Jul 2003 19:09:28 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: backblue <backblue@netcabo.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Error compiling, scsi 2.6.0-test1
References: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com>	<ODEIIOAOPGGCDIKEOPILAEBDCNAA.alan@storlinksemi.com> <20030716232827.2272eccb.backblue@netcabo.pt>
In-Reply-To: <20030716232827.2272eccb.backblue@netcabo.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

backblue wrote:
<snip>
> drivers/scsi/ini9100u.c:111:2: #error Please convert me to Documentation/DMA-mapping.txt
<snip>

Looks like the driver has not been converted to work in 2.5.

-Rahul

