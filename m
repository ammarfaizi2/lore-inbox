Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUAKWSz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUAKWSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:18:55 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:56714 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266005AbUAKWSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:18:48 -0500
Message-ID: <4001CB91.2040903@yahoo.com.br>
Date: Sun, 11 Jan 2004 20:17:53 -0200
From: Lucas de Souza Santos <lucasdss@yahoo.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030915
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: trelane@digitasaru.net, linux-kernel@vger.kernel.org
Subject: Re: SoundBlaster 64 AWE and 2.6.1-mm1?
References: <20040110191950.GD5002@digitasaru.net>
In-Reply-To: <20040110191950.GD5002@digitasaru.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Pingenot wrote:
> Hello.
> 
> For some reason, while pnp detects the SoundBlaster card, it's not
>   recognized by ALSA for some reason, exactly as the CS4236 card was
>   (different machine, tho).
> Am I missing something?  Anyone using SoundBlaster 64 AWE under 2.6?
> Thanks!
> 
> -Joseph
Hi, i'm using SB Awe 64 under 2.6.
It's working, but i have to uso sound support with build-in, i try use 
sound support like mudule, but didn't work, the module snd-sbawe return 
"device not found".

thank's

-- 
Lucas de Souza Santos


