Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVEQOQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVEQOQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 10:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVEQOQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 10:16:45 -0400
Received: from 4.34.76.83.cust.bluewin.ch ([83.76.34.4]:33086 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261466AbVEQOQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 10:16:35 -0400
Date: Tue, 17 May 2005 16:13:07 +0200
From: Karel Kulhavy <clock@twibright.com>
To: Jan Spitalnik <jan@spitalnik.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software mixing in alsa
Message-ID: <20050517141307.GA7759@kestrel>
References: <20050517095613.GA9947@kestrel> <200505171208.04052.jan@spitalnik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200505171208.04052.jan@spitalnik.net>
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 12:08:03PM +0200, Jan Spitalnik wrote:
> Dne út 17. kvìtna 2005 11:56 Karel Kulhavy napsal(a):
> > Hello
> >
> > http://www.math.tu-berlin.de/~sbartels/alsa/driver/driver.html says
> > "For example, there is currently ongoing work to allow mixing multiple
> > inputs to the pcm devices."
> >
> 
> Hi,
> 
> yes, ALSA can mix multiple inputs with its dmix plugin.
> http://alsa.opensrc.org/index.php?page=DmixPlugin

Thanks for your reply.  I have proceeded according to this "Dmix Howto",
however it doesn't work. I have proceeded successfully up to the command
"aoss mpg123 some.mp3". When I run this, mp3 is played very fast, in
about 1-2 seconds (normal pitch, but skipping very fast forward).

mpg123 Version 0.59s-r9 (2000/Oct/27)
aoss doesn't have --version option
alsaplayer 0.99.76

The document doesn't contain any contact where to send bugreports that
the course described actually doesn't work.

Any other idea how to make Skype & XMMS run at the same time on Linux?

CL<
