Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273664AbRIQTzx>; Mon, 17 Sep 2001 15:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273669AbRIQTzn>; Mon, 17 Sep 2001 15:55:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50306 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S273664AbRIQTzg>; Mon, 17 Sep 2001 15:55:36 -0400
Date: Mon, 17 Sep 2001 15:55:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bruce Blinn <blinn@MissionCriticalLinux.com>
cc: Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <3BA6517F.B0E18888@MissionCriticalLinux.com>
Message-ID: <Pine.LNX.3.95.1010917155338.17362A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Bruce Blinn wrote:
[SNIPPED...]

Just do `cp /dev/cdrom /tmp/foo`. ^C out when you think you have
enough, then use `dd` to copy a small portion of the image file.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


