Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264121AbTEJNqc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 09:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264125AbTEJNqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 09:46:32 -0400
Received: from dclient217-162-28-172.hispeed.ch ([217.162.28.172]:8466 "EHLO
	homegate.delouw.ch") by vger.kernel.org with ESMTP id S264121AbTEJNqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 09:46:30 -0400
Message-ID: <3EBCFCDB.8030505@delouw.ch>
Date: Sat, 10 May 2003 15:21:31 +0200
From: Luc de Louw <luc@delouw.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: de-ch, zh, en-us, ro, eu, fr-fr, da, ru, pt, hu, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCHLET] for typo in reiserfs in 2.4.21-rc2
References: <3EBCD7F0.3040700@delouw.ch>
In-Reply-To: <3EBCD7F0.3040700@delouw.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luc de Louw wrote:
> Hi,
> 
> I found a small typo in fs/reiserfs/do_balan.c which makes in unable to 
> compile the reiserfs module.

Please ignore the previous mail.

I obviousely had problems with my system, the IDE-driver included in the 
SuSE kernel corrupted parts of my filesystems.

After rebooting I was able to apply the patch again, and then the typo 
was gone...

Now I got a stable kernel :-)

Sorry for the confusion....

rgds

Luc

