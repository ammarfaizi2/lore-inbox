Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270000AbTHFK7D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270707AbTHFK7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:59:03 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:64519 "EHLO
	mail1.cybertrails.com") by vger.kernel.org with ESMTP
	id S270000AbTHFK7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:59:01 -0400
Date: Wed, 6 Aug 2003 03:58:55 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: My report on running 2.6.0-test2 on a Dell Inspiron 7000 (poor
 sound from crond)
Message-Id: <20030806035855.46b3cadf.dickson@permanentmail.com>
In-Reply-To: <20030806021621.2da5a850.dickson@permanentmail.com>
References: <20030806021621.2da5a850.dickson@permanentmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 02:16:21 -0700, Paul Dickson wrote:

> Before, flipping between workspaces would cause music (under xmms) to
> skip.  It no longer does that.
> 
> But all is not perfect.  I'll attach the problems I had as replies (so
> each has it's own message thread).


While xmms, launched under Gnome, doesn't skip, ogg123 launch via crond
does.

I have a subscription to an daily audio program that arrives monthly via
CD.  I have a crontab entry which plays each day's program automatically.

Under 2.6.0-test2, there are lot's of skips when the short 2 minute
file is played.

	-Paul

