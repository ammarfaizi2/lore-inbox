Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRECPRK>; Thu, 3 May 2001 11:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131323AbRECPRB>; Thu, 3 May 2001 11:17:01 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:7437 "EHLO
	mail.compro.net") by vger.kernel.org with ESMTP id <S131244AbRECPQn>;
	Thu, 3 May 2001 11:16:43 -0400
Message-ID: <3AF17679.DCD39840@compro.net>
Date: Thu, 03 May 2001 11:17:13 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: markh@compro.net
Subject: raw tape device support???
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Sorry if this isn't the correct place for this question. Is there or
will there
ever be raw tape device access. I'm trying to port an app from Dec unix
and at
least there the app requires /dev/rmt** (raw device). I've read in the
archives
about how to bind a block device to a raw device using the raw command
but the
tape dev (/dev/st*) is a char device and the command doesn't work on
char devices.
So I'm trying to figure out to get the same effect as /dev/rmt* does on
the dec
box in a linux environment. 
 I'm not a member of this list (sorry) so if anyone can respond to this
please
cc to it markh@compro.net.

Thank you very much in advance

Mark Hounschell
markh@compro.net
