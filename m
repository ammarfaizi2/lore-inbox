Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287276AbSACRIT>; Thu, 3 Jan 2002 12:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288267AbSACRIC>; Thu, 3 Jan 2002 12:08:02 -0500
Received: from ns.suse.de ([213.95.15.193]:44036 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287276AbSACRHm>;
	Thu, 3 Jan 2002 12:07:42 -0500
Date: Thu, 3 Jan 2002 18:07:36 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Andreas Bombe <bombe@informatik.tu-muenchen.de>
Cc: Shaya Potter <spotter@opus.cs.columbia.edu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Dual athlon XP 1800 problems
In-Reply-To: <20020103165321.GA737@bombe.modem.informatik.tu-muenchen.de>
Message-ID: <Pine.LNX.4.33.0201031806360.11961-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Andreas Bombe wrote:

> The identification string is written by the BIOS.  Yours didn't know
> about XPs so it misidentified them as MPs.  Upgrade your BIOS if this
> bugs you.
>
> If ID string contradicts what you think you bought, don't trust the ID
> string.

x86info, and 2.5.2-dj11 both have code to correctly determine XP / MP.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

