Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbTDPQyB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTDPQx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:53:58 -0400
Received: from coral.ocn.ne.jp ([211.6.83.180]:42483 "HELO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with SMTP id S264501AbTDPQwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:52:21 -0400
Date: Thu, 17 Apr 2003 02:04:13 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-English user messages
Message-Id: <20030417020413.49af6390.bharada@coral.ocn.ne.jp>
In-Reply-To: <3E9D688F.5040204@techsource.com>
References: <E195cDL-00013K-00@w-gerrit2>
	<3E9D688F.5040204@techsource.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Suggestion: Chop your CCs. I sus pect Linus gave up on this topic a long time
ago, as (most likely) have the majority of the others.

On Wed, 16 Apr 2003 10:28:31 -0400
Timothy Miller <miller@techsource.com> wrote:

> The Japanese are taught to read and write English as school children. 
>  They also are taught how to write their own language in Romanji, which 
> is an adaptation of the Roman alphabet.

No, they're not (taught to write Japanese in Romaji, that is).

>  How much you want to bet that 
> the Japanese use English when they write error messages?

Well, it rather depends on the person... try setting your locale to
ja_JP.eucJP, and you might be surprised by the applications that give you
Japanese messages. Certainly, some Japanese people prefer messages in
English, but that can hardly be generalized across the entire userbase.

> Linus Torvalds isn't the first Finn I've encountered who speaks, reads, 
> and writes English impeccably.
> 
> I've also never met a German who didn't speak English.
> 
> When we have Asian vendors from various countries come visit where I 
> work, even the ones who need a translator speak English better than we 
> speak their language.

My only answer is, you have only had the opportunity to meet people from
overseas who have some English ability... really, your argument is on the same
level as "I've got lots of foreign friends who all like <whatever>, so all
foreigners must like <whatever>."


Bruce


PS: I'm against translating kernel messages, but for technical reasons (simple
== good) rather than some wild idea that everybody else in the world can
understand English.

