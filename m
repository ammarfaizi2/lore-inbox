Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWHQQCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWHQQCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWHQQCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:02:38 -0400
Received: from a.relay.invitel.net ([62.77.203.3]:28800 "EHLO
	a.relay.invitel.net") by vger.kernel.org with ESMTP id S932515AbWHQQCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:02:37 -0400
Date: Thu, 17 Aug 2006 18:02:47 +0200
From: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Vernon Mauery <vernux@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Eric Piel <Eric.Piel@tremplin-utc.net>,
       Steve Barnhart <stb52988@gmail.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bootsplash integration
Message-ID: <20060817160247.GB25136@lgb.hu>
Reply-To: lgb@lgb.hu
References: <15ce3ec0608110736y5ef185e8v6acd4f7556adcc49@mail.gmail.com> <44DCB95B.4060101@tremplin-utc.net> <1155317729.24077.110.camel@localhost.localdomain> <200608120727.58446.vernux@us.ibm.com> <Pine.LNX.4.61.0608121913490.2346@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0608121913490.2346@yvahk01.tjqt.qr>
X-Operating-System: vega Linux 2.6.15-25-686 i686
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 07:14:33PM +0200, Jan Engelhardt wrote:
> >mplayer knows how to play to a framebuffer on the console without X.  So this 
> >is possible.  I have played a movie on my framebuffer before.
> 
> mplayer even works without framebuffer, and I am not talking about aalib or 
> caca, but cvidix.

As an ex-developer of MPlayer I should say that MPlayer even supports direct
hardware access and such if you're brave enough ;-)

http://www.mplayerhq.hu/DOCS/HTML-single/en/MPlayer.html#vidix

-- 
- Gábor
