Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275003AbTHRUjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275014AbTHRUjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:39:51 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:23967 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S275003AbTHRUjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:39:48 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 18 Aug 2003 22:39:46 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030818223946.182b0aab.skraw@ithnet.com>
In-Reply-To: <20030818202949.GD10320@matchmail.com>
References: <3F325198.2010301@namesys.com>
	<20030807153257.1f2f80b0.skraw@ithnet.com>
	<20030818202949.GD10320@matchmail.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 13:29:49 -0700
Mike Fedyk <mfedyk@matchmail.com> wrote:

> > I'd say "two things differ", without trailing "s". I am not even sure if
> > "bitmaps" shouldn't be singular "bitmap" instead.
> 
> "bitmaps" with your changes would be correct.
> 
> Though, just turn "bitmaps" into "bitmap" and it should be fine.  I can't
> really think of a phrase specific enough for the error message without
> adding enough text to make it two lines, which wouldn't be good.
> 
> "Comparing bitmaps.. vpf-10640: The on-disk and the correct bitmap differs"

Hm, but:

"a and b differ"
"a differs from b"

or not?

Alternatives:

"a and b are different"

But if you use "are" here, you cannot use "differs" above, right?

Regards,
Stephan
