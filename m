Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270672AbTGURqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270608AbTGURhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:37:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49166 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270627AbTGURfT (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 21 Jul 2003 13:35:19 -0400
Subject: Re: swsusp / 2.6.0-test1
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: linux-kernel@vger.redhat.com
Cc: Pavel Machek <pavel@suse.cz>
In-Reply-To: <1058805510.15585.7.camel@simulacron>
References: <1058805510.15585.7.camel@simulacron>
Content-Type: text/plain
Message-Id: <1058806128.15586.10.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Jul 2003 18:48:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-21 at 18:38, Andreas Jellinghaus wrote:
> swsusp is working fine, but mplayer
> in sdl and xv output mode displays a blank
> screen after a resume. 

I meant to write:

star mplayer: works fine.
end mplayer
suspend
resume
start mplayer: no video
end mplayer
start mplayer -vo sdl: no video
end mplayer
start mplayer -vo x11: video.
(but x11 video output does not scale the video to full screen.)

Andreas

