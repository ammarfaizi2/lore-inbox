Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUCWX2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbUCWX2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:28:18 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:10853 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262910AbUCWX2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:28:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Date: Tue, 23 Mar 2004 17:43:00 -0500
User-Agent: KMail/1.6.1
Cc: Pavel Machek <pavel@suse.cz>, Jonathan Sambrook <swsusp@hmmn.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040323095318.GB20026@hmmn.org> <20040323214734.GD364@elf.ucw.cz>
In-Reply-To: <20040323214734.GD364@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403231743.01642.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 March 2004 04:47 pm, Pavel Machek wrote:
> Hi!
> 
<skip>

> Also, in your model, where do messages printk()-ed from drivers during
> suspend/resume end up? Corrupting screen? Lost from sight and only
> accessible from dmesg? I believe driver messages *are* important, and
> do not see how they could coexist with eye-candy.
> 
Well, unless these are error messages that prevent machine from suspending/
resuming they are really just another form of eye-candy, nothing more,
nothing less.

-- 
Dmitry
