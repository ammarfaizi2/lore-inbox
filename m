Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbUL0Tfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbUL0Tfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUL0Tfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:35:45 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:3624 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261948AbUL0Tfj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:35:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bQL7iSoYCIYOob/p6CtOsGyMTw1w1MV0NaPGd2cHdp6w0Dh0uT4U7rzPfIUVYQD6lUjPvbHBbXR+MfsJ57djyIoIDFJzXdw1yxIGMaLF4PzBw8hIxj/LWn3SFpCpA/UknnsaO6fvrTHrMQTz0pZe1uFxlKtvkmT6PVrMM1YAX90=
Message-ID: <d5a95e6d04122711355a0a9b04@mail.gmail.com>
Date: Mon, 27 Dec 2004 16:35:38 -0300
From: Diego <foxdemon@gmail.com>
Reply-To: Diego <foxdemon@gmail.com>
To: Michelle Konzack <linux4michelle@freenet.de>
Subject: Re: About NFS4 in kernel 2.6.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041227192508.GC18869@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <d5a95e6d04122711183596d0c8@mail.gmail.com>
	 <20041227192508.GC18869@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First sorry about my poor english. I read in internet that it´s best
if i recompile NFS4 as module, so i did it. But i have this error
message. I dont know wht to do. when i do make xconfig, in filesystem,
i have checked all that have NFS and RPC, but it insist in not work.


On Mon, 27 Dec 2004 20:25:08 +0100, Michelle Konzack
<linux4michelle@freenet.de> wrote:
> Hello Diego,
> 
> Am 2004-12-27 16:18:00, schrieb Diego:
> 
> > Iniciando NFS4 idmapd: FATAL: Module sunrpc not found.
> > FATAL: Error running install command for sunrpc
> >
> > I dont know what is the problem, whem i recompile the kernel, i
> > compile support to NFSv4. Somebody help me, please.
> > Thanks for your help.
> 
> The output told you that it does not find "sunrpc" so you
> need ot compile it for your kernel. What do you mean ?
> 
> > Diego.
> 
> Greetings
> Michelle
> 
> --
> Linux-User #280138 with the Linux Counter, http://counter.li.org/
> Michelle Konzack   Apt. 917                  ICQ #328449886
>                   50, rue de Soultz         MSM LinuxMichi
> 0033/3/88452356    67100 Strasbourg/France   IRC #Debian (irc.icq.com)
> 
> 
>
