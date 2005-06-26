Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVFZSIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVFZSIT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 14:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVFZSIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 14:08:19 -0400
Received: from mail.linicks.net ([217.204.244.146]:49931 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261525AbVFZSIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 14:08:14 -0400
From: Nick Warne <nick@linicks.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IDE probing IDE_MAX_HWIFS
Date: Sun, 26 Jun 2005 19:08:12 +0100
User-Agent: KMail/1.8.1
References: <200506251210.37623.nick@linicks.net> <1119808271.28644.33.camel@localhost.localdomain>
In-Reply-To: <1119808271.28644.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506261908.12398.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 18:51, you wrote:
> On Sad, 2005-06-25 at 12:10, Nick Warne wrote:
> > Looking at the Kconfig, I see APLHA & SUPERH do get an option to change
> > this to suit
> > drivers/ide/Kconfig
>
> To make embedded systems as small as possible
>
> > Now my question :-)  Is there a specific reason why this isn't included
> > in other architectures?
>
> They are not embedded ?

Heh.  Yes I know now, but I was thinking along the lines that if someone knows 
how many IDE interfaces they have it could be specified exactly - I 
didn't/don't see why it is considered an option for config_embedded only to 
be allowed to do that.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
