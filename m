Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUCRHRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 02:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUCRHRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 02:17:43 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:53377 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262448AbUCRHRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 02:17:41 -0500
Date: Thu, 18 Mar 2004 08:18:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Williams <peterw@aurema.com>
Cc: =?iso-8859-1?B?IkZy6WTpcmljIEwuIFcuIE1ldW5pZXIi?= 
	<1@pervalidus.net>,
       linux-kernel@vger.kernel.org
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong thing
Message-ID: <20040318071854.GB499@ucw.cz>
References: <40593015.9090507@aurema.com> <Pine.LNX.4.58.0403180346000.1276@pervalidus.dyndns.org> <40594984.3010001@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40594984.3010001@aurema.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 06:02:28PM +1100, Peter Williams wrote:

> Frédéric L. W. Meunier wrote:
> >Wrongly ?
> 
> Yes, wrongly.  XFree86 wasn't even running when the messages appeared so 
> there's no way that it could be to blame.  Also no keys had been pressed 
> or released.

XFree86 wasn't the only one doing that. Old versions of 'kbdrate' have
did direct HW accesses, too.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
