Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129619AbRCCRkw>; Sat, 3 Mar 2001 12:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbRCCRkm>; Sat, 3 Mar 2001 12:40:42 -0500
Received: from [139.102.15.118] ([139.102.15.118]:168 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S129619AbRCCRkd>; Sat, 3 Mar 2001 12:40:33 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rich Baum <richbaum@acm.org>
To: davidge@jazzfree.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: simple question about patches
Date: Sat, 3 Mar 2001 12:41:26 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.21.0103031812550.1447-100000@roku.redroom.com>
In-Reply-To: <Pine.LNX.4.21.0103031812550.1447-100000@roku.redroom.com>
MIME-Version: 1.0
Message-Id: <01030312412600.02510@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 March 2001 12:18 pm, davidge@jazzfree.com wrote:
> Hi, i've got a newbie question about patches:
> Are the pre* patches ( and i guess also the ac* ones) applied against the
> last release of the kernel or against the previous patch? I mean, when
> 2.4.3pre2 will come out, i need to get also the pre1 patch?
>
> thanks
>
>
> David Gómez
>
> "The question of whether computers can think is just like the question of
>  whether submarines can swim." -- Edsger W. Dijkstra
>
>

They're applied against the last release.  To remove the old patch run the 
same command you used to patch the kernel only add a -R after the patch 
command.
