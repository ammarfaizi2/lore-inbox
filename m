Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbVLaTOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVLaTOP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 14:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVLaTOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 14:14:15 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:28364 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S965040AbVLaTOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 14:14:14 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Bradley Reed <bradreed1@gmail.com>
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Date: Sat, 31 Dec 2005 19:14:34 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20051231202933.4f48acab@galactus.example.org> <200512311847.48296.s0348365@sms.ed.ac.uk> <20051231205931.119f3dc7@galactus.example.org>
In-Reply-To: <20051231205931.119f3dc7@galactus.example.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512311914.34067.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 December 2005 18:59, Bradley Reed wrote:
> On Sat, 31 Dec 2005 18:47:48 +0000
>
> Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > Try mplayer -nortc? If that work's it'll confirm the problem is with
> > opening the rtc device.
>
> It works fine with the -nortc option. I wonder why it can't open it? It
> exists and the perms look pretty wide open.

That's a question for one of the hr-timer guys, but it's 2006 in just under 
five hours here, so it might take a while for somebody to get back to you :-)

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
