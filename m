Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288392AbSACXlU>; Thu, 3 Jan 2002 18:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288395AbSACXlA>; Thu, 3 Jan 2002 18:41:00 -0500
Received: from [212.2.162.33] ([212.2.162.33]:60908 "EHLO weasel")
	by vger.kernel.org with ESMTP id <S288393AbSACXky>;
	Thu, 3 Jan 2002 18:40:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: David Golden <david.golden@oceanfree.net>
Organization: Legion
To: linux-kernel@vger.kernel.org
Subject: Re: losetuping files in tmpfs fails?
Date: Thu, 3 Jan 2002 23:42:08 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <3C2F0AEE.ACABAAFA@silver.unix-fu.org> <3C34E4DF.F439FD70@zip.com.au>
In-Reply-To: <3C34E4DF.F439FD70@zip.com.au>
MIME-Version: 1.0
Message-Id: <02010323420802.01549@golden1.goldens.ie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 January 2002 23:10, Andrew Morton wrote:
> It's not obvious that there's a burning need to support loop-on-tmpfs
> though, is there?
>

/sbin/mkinitrd and /sbin/mkinitd_helper in major distros tend to loop back on 
files called  /tmp/initird.blah to make the images.

