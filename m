Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSJCUqw>; Thu, 3 Oct 2002 16:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbSJCUqw>; Thu, 3 Oct 2002 16:46:52 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:24077 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261353AbSJCUqv>;
	Thu, 3 Oct 2002 16:46:51 -0400
Date: Thu, 3 Oct 2002 22:50:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003225046.B1411@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20021003223054.A31484@mars.ravnborg.org> <Pine.LNX.4.44.0210031536370.24570-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210031536370.24570-100000@chaos.physics.uiowa.edu>; from kai-germaschewski@uiowa.edu on Thu, Oct 03, 2002 at 03:38:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 03:38:22PM -0500, Kai Germaschewski wrote:
> On Thu, 3 Oct 2002, Sam Ravnborg wrote:
> 
> > On Thu, Oct 03, 2002 at 10:01:20PM +0200, Sam Ravnborg wrote:
> > > Now it's testing time..
> 
> [...]
> 
> You must be missing some of the changes (My first push to bkbits was 
> incomplete, since I did inadvertently edit Makefile without checking it 
> out, I do that mistake all the time...). It's fixed in the current repo.

This time I applied the patch you sent in the mail.
Checking bkbits....
Yep, the latest csets on bkbits fixes some of this.

	Sam
