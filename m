Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271881AbRIDCcF>; Mon, 3 Sep 2001 22:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271880AbRIDCbz>; Mon, 3 Sep 2001 22:31:55 -0400
Received: from OSTRICH.RES.CMU.EDU ([128.2.151.162]:54281 "HELO
	ostrich.res.cmu.edu") by vger.kernel.org with SMTP
	id <S271879AbRIDCbg>; Mon, 3 Sep 2001 22:31:36 -0400
Date: Mon, 3 Sep 2001 22:31:55 -0400
From: Benjamin Gilbert <bgilbert@backtick.net>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Ghozlane Toumi <gtoumi@messel.emse.fr>, linux-kernel@vger.kernel.org
Subject: Re: matroxfb problems with dualhead G400
Message-ID: <20010903223155.A13243@ostrich.andrew.cmu.edu>
In-Reply-To: <26751224E05@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <26751224E05@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Mon, Sep 03, 2001 at 02:51:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 02:51:44PM +0000, Petr Vandrovec (VANDROVE@vc.cvut.cz) wrote:
> You must boot your kernel with 'video=scrollback:0'. Otherwise your
> kernel die sooner or later... JJ's scrollback code does not cope with
> more than one visible console, so you must disable it if you have more
> than one display in the box.

That doesn't fix it.  Shift-PgUp no longer works (of course), and
it's not immediately oopsing on me, but I still have the same type of
intrusion onto the secondary display.

--Benjamin Gilbert
