Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312971AbSDBWKK>; Tue, 2 Apr 2002 17:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312972AbSDBWKA>; Tue, 2 Apr 2002 17:10:00 -0500
Received: from web13104.mail.yahoo.com ([216.136.174.149]:45071 "HELO
	web13104.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312971AbSDBWJs>; Tue, 2 Apr 2002 17:09:48 -0500
Message-ID: <20020402220947.93602.qmail@web13104.mail.yahoo.com>
Date: Tue, 2 Apr 2002 23:09:47 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Screen corruption in 2.4.18
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <140CACD08D8@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Petr Vandrovec <VANDROVE@vc.cvut.cz> wrote:
> On  2 Apr 02 at 22:43, Chris Rankin wrote:
> It is something completely different - your color
> rectangle is xine (or Xv)
> still painting to framebuffer although X are no
> longer visible. If
> you are using matroxfb, you should see either single
> color rectangle
> (in overlay mode) or picture from xine (in direct
> paint mode). With
> vgacon you'll see single color areas of strange
> stable characters in overlay
> mode, and multicolored areas of strange changing
> characters in non-overlay
> mode.

OK, but for the record, I'm not using a framebuffer.
My console is text-mode.

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
