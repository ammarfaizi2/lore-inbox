Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVJBFgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVJBFgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 01:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVJBFgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 01:36:13 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:59347 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750975AbVJBFgN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 01:36:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pYJ+tWzYiDXLVC0DM7TzwrH0CQC4sSjTUCwOGXDZpBBwWBAa7Xid9Q5dGi8AetnrflJ6Z7abAnZYfky0oyvFOmi8cXIM2Zcrvr34O41DItMRXgVMK0bSCijyUChX+k+248GozZQF14xAEOm/5bDircenBrjASYRSd0QjUndZ+to=
Message-ID: <105c793f0510012236j16033efbh400f6f2a8495d03e@mail.gmail.com>
Date: Sun, 2 Oct 2005 01:36:12 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: lokum spand <lokumsspand@hotmail.com>
Subject: Re: A possible idea for Linux: Save running programs to disk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/05, lokum spand <lokumsspand@hotmail.com> wrote:
> ... a program like mozilla with many open windows. I give
> it a SIGNAL-SAVETODISK and the process memory image is dropped to a
> file. I can then turn off the computer and later continue using the
> program where I left it, by loading it back into memory.
FWIW, you can already do this with Firefox (and Mozilla, I'm sure)
using the Sessionsaver plugin.

And while I can shed no further light on your idea, I wholeheartedly
support it. It would be a nice alternative to swsusp/Suspend2 in that
it could possibly avoid hardware issues involved with hibernation.

-Andy
