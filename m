Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSJCT2S>; Thu, 3 Oct 2002 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSJCT2S>; Thu, 3 Oct 2002 15:28:18 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:25363 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261276AbSJCT2R>;
	Thu, 3 Oct 2002 15:28:17 -0400
Date: Thu, 3 Oct 2002 21:33:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003213301.A25411@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu> <20021003212618.A17403@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021003212618.A17403@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Oct 03, 2002 at 09:26:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 09:26:18PM +0200, Sam Ravnborg wrote:
> 
> Hmmm, was the stuff present at bkbits incomplete?

Just checked, yes the attached patch was never. And fixes I think all the
above.

A new round of testing needed....

	Sam
