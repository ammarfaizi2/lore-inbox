Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270159AbTGMH7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 03:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270161AbTGMH7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 03:59:06 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:12556 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S270159AbTGMH7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 03:59:02 -0400
Date: Sun, 13 Jul 2003 01:13:38 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Message-ID: <20030713081338.GA13265@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Davide Libenzi <davidel@xmailserver.org>
References: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain> <55580000.1057727591@[10.10.2.4]> <20030709051941.GK15452@holomorphy.com> <20030709054307.GL15452@holomorphy.com> <Pine.LNX.4.55.0307121656060.4720@bigblue.dev.mcafeelabs.com> <20030713001123.GD15452@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713001123.GD15452@holomorphy.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 05:11:23PM -0700, William Lee Irwin III wrote:
> On Tue, 8 Jul 2003, William Lee Irwin III wrote:
> >    ^^^^^^^^^^^^^^^
> 
> On Sat, Jul 12, 2003 at 04:58:55PM -0700, Davide Libenzi wrote:
> > Is it just me that is receiving dups from lkml or it's a common disease ?
> 
> The story is all in the headers:
> 
> Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
>         id S269995AbTGLXao (ORCPT <rfc822;wli@holomorphy.com>);
>         Sat, 12 Jul 2003 19:30:44 -0400
> Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270018AbTGLXao
>         (ORCPT <rfc822;linux-kernel-outgoing>);
>         Sat, 12 Jul 2003 19:30:44 -0400
> Received: from pip15.ptt.js.cn ([61.155.13.245]:9629 "HELO jlonline.com")
>         by vger.kernel.org with SMTP id S269995AbTGLXa2 (ORCPT
>         <rfc822;linux-kernel@vger.kernel.org>);
>         Sat, 12 Jul 2003 19:30:28 -0400
> Received: from jlonline.com([10.100.0.6]) by js.cn(AIMC 2.9.5.2)
>         with SMTP id jm43f10fd18; Sun, 13 Jul 2003 07:33:56 +0800
> Received: from kanga.kvack.org([216.138.200.138]) by js.cn(AIMC 2.9.5.2)
>         with SMTP id jm343f0c0ba8; Wed, 09 Jul 2003 13:35:56 +0800
> Received: (root@kanga.kvack.org) by kvack.org id <S26870AbTGIFmJ>;
>         Wed, 9 Jul 2003 01:42:09 -0400
> Received: from holomorphy.com ([66.224.33.161]:56232 "EHLO holomorphy")
>         by kvack.org with ESMTP id <S26867AbTGIFlw> convert rfc822-to-8bit;
>         Wed, 9 Jul 2003 01:41:52 -0400
> Received: from wli by holomorphy with local (Exim 3.36 #1 (Debian))
>         id 19a7jQ-0004Pg-00; Tue, 08 Jul 2003 22:43:08 -0700
> 
> It's clearly well upstream from me.

More to the point:

| To: "Martin J. Bligh" <mbligh@aracnet.com>,
|         Ingo Molnar <mingo@elte.hu>,
| linux-kernel@vger.kernel.org,
|         linux-mm@kvack.org

and finally:

| --
| To unsubscribe, send a message with 'unsubscribe linux-mm' in
| the body to majordomo@kvack.org.  For more info on Linux MM,
| see: http://www.linux-mm.org/ .
| Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at
| http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/

linux-mm is forwarding to linux-kernel without adequate
checking to see if it is already going there.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
