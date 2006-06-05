Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751011AbWFELvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWFELvJ (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWFELvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:51:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:13251 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751010AbWFELvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:51:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LPvQ26aVGrvVcYGr+e5/62PxTePlC+zzxsLfikQLKmItKqGYDOAXyBBE7ZHAazUSecsjnY3WmhCtDD7TbWEU3a1RRaf757pG1m/Sbjj374eBy2F8MKkXgnY84YmxTQJ9FOjnV70pUs4QkxvGImZQwslwqSWuqmp9iNFsPQ6PeVc=
Message-ID: <44841AA0.4060404@gmail.com>
Date: Mon, 05 Jun 2006 20:50:56 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] swsusp: allow drivers to determine between write-resume
 and actual wakeup
References: <20060605091131.GE8106@htj.dyndns.org> <20060605092342.GI5540@elf.ucw.cz>
In-Reply-To: <20060605092342.GI5540@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> If you want to know if you RESUME was after normal FREEZE or if it is
> after reboot, there's better patch floating around to do that.

Yeap, this is what I'm interested in.  Care to give me a pointer?

Thanks.

-- 
tejun
