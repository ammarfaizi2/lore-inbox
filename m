Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291432AbSBSOfH>; Tue, 19 Feb 2002 09:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291431AbSBSOer>; Tue, 19 Feb 2002 09:34:47 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:36094 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S291430AbSBSOei>; Tue, 19 Feb 2002 09:34:38 -0500
Date: Tue, 19 Feb 2002 15:32:48 +0100
From: Kristian <kristian.peters@korseby.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: 2.4.18-pre9-ac4 filesystem corruption
Message-Id: <20020219153248.39a1b7fc.kristian.peters@korseby.net>
In-Reply-To: <E16dB0A-0000aZ-00@the-village.bc.nu>
In-Reply-To: <20020219135758.67f7f4c2.kristian.peters@korseby.net>
	<E16dB0A-0000aZ-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: Debian GNU/Linux 2.4.17
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> PIIX and the WDC drive is supposed to be past the range that had the
> nasty UDMA DMA bugs.
> 
> > Before you ask: I'll test memory later just to be sure.	
>  
> Ok

memtest86 completed successfully.

I'll test with -rc2-ac1 for ext2 corruption again.

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :..........................:
