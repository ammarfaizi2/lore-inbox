Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289365AbSA1ULF>; Mon, 28 Jan 2002 15:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289367AbSA1UKz>; Mon, 28 Jan 2002 15:10:55 -0500
Received: from peabody.ximian.com ([141.154.95.10]:11012 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP
	id <S289351AbSA1UKm>; Mon, 28 Jan 2002 15:10:42 -0500
Subject: Re: Ethernet data corruption?
From: Kevin Breit <mrproper@ximian.com>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020128145238.19243A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020128145238.19243A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.23.19.37 (Preview Release)
Date: 28 Jan 2002 15:13:23 -0600
Message-Id: <1012252404.6097.7.camel@kbreit.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-28 at 13:58, Richard B. Johnson wrote:
> Every TCP/IP data packet is check-summed. Every Ethernet packet has
> a CRC. If you have data corruption it is caused either by a memory
> error or, most likely, you did not set the ftp data-transfer mode
> to binary `set bin` when you have the 'ftp>' prompt.
I believed that I was uploading in bin mode anyways.  As when I opened
gftp, it said I was uising Binary mode.

 
> Also, text-files (Java Script) on DOS-based stuff (like windows) use
> both a '\r' and a '\n' at the end of each line. Unix/Linux uses '\n'
> only. I am pretty sure this is not a kernel issue.
My professor's server is a Mac box.  I doubt this is an issue anyways.

Thanks

Kevin Breit

