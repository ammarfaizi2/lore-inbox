Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbTGILrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 07:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbTGILrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 07:47:07 -0400
Received: from mail.ithnet.com ([217.64.64.8]:22545 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265387AbTGILrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 07:47:05 -0400
Date: Wed, 9 Jul 2003 14:01:38 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030709140138.141c3536.skraw@ithnet.com>
In-Reply-To: <1057515223.20904.1315.camel@tiny.suse.com>
References: <20030706183453.74fbfaf2.skraw@ithnet.com>
	<1057515223.20904.1315.camel@tiny.suse.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Jul 2003 14:13:44 -0400
Chris Mason <mason@suse.com> wrote:

> [...]
> Is reiserfs on your root drive?  If not can you please boot into single
> user mode, enable sysrq, try the mount again and get the decoded output
> from sysrq-p and sysrq-t if it hangs.
> 
> -chris

Hello Chris,

I tried to produce some useful output but failed. Additionals I found:

- pre3-ac1 has the same problem
- the box _hangs_ in fact, no sysrq is working.
  (you need hw-reset to revive the box)
- I can see no disk activity on the 3ware RAID in question
- It always shows up, completely reproducable
- It shows during boot and during single- or multiuser (mount from console)

Regards,
Stephan

