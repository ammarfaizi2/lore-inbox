Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287254AbSBKFwK>; Mon, 11 Feb 2002 00:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287276AbSBKFwA>; Mon, 11 Feb 2002 00:52:00 -0500
Received: from angband.namesys.com ([212.16.7.85]:7821 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S287254AbSBKFvq>; Mon, 11 Feb 2002 00:51:46 -0500
Date: Mon, 11 Feb 2002 08:51:40 +0300
From: Oleg Drokin <green@namesys.com>
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020211085140.B27189@namesys.com>
In-Reply-To: <20020207082348.A26413@riesen-pc.gr05.synopsys.com> <20020207104420.A6824@namesys.com> <20020207230235.A173@steel> <20020208085155.A7034@namesys.com> <20020208230713.A13545@steel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208230713.A13545@steel>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Feb 08, 2002 at 11:07:13PM +0100, Alex Riesen wrote:

> hmm.. You're demanding too much(mkreiserfs) - it's my home partition :)
At least reiserfsck before any tests is almost mandratory ;)

> Maybe the corruptions are from previous kernels, but the zero-files
> are observed for the first time, particularly in the .bash_history.
Yes, but you said with the patch you cannot reproduce zero files anymore.

> Sorry for such a dirty test environment, i was really not prepared.
> Logs attached.
I am sorry, but there are so many variables, these logs are barely useful as
of now.
If you can reproduce on a clean filesystem with not faulty hardware, that would be interesting, though.

Thank you.

Bye,
    Oleg
