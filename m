Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130615AbRAZSTh>; Fri, 26 Jan 2001 13:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130701AbRAZST2>; Fri, 26 Jan 2001 13:19:28 -0500
Received: from smtp.primusdsl.net ([209.225.164.93]:24836 "EHLO
	mailhost.digitalselect.net") by vger.kernel.org with ESMTP
	id <S130615AbRAZSTM>; Fri, 26 Jan 2001 13:19:12 -0500
Date: Fri, 26 Jan 2001 13:19:49 -0500
From: James Lewis Nance <jlnance@intrex.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Renaming lost+found
Message-ID: <20010126131949.A1041@bessie.dyndns.org>
In-Reply-To: <20010126141350.Q6979@capsi.com> <Pine.LNX.3.95.1010126084632.208A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.95.1010126084632.208A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Jan 26, 2001 at 08:49:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 08:49:31AM -0500, Richard B. Johnson wrote:

> On Fri, 26 Jan 2001, Rob Kaper wrote:
> > Is there a way to rename lost+found ?? It bothers me to see it in ls all the

> Get used to it. This is part of the Linux/Unix heritage!  A file-system
> without a lost+found directory is like love without sex.

FWIW IBM's JFS file system does not have a lost+found directory.  I dont
remember if reiserfs does or not.

Jim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
