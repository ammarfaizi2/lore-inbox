Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275216AbTHRViI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275218AbTHRViI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:38:08 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:16147 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S275216AbTHRViE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:38:04 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: [grammar] 2.4.22-pre lockups (now decoded oops for pre10) 
Date: Mon, 18 Aug 2003 22:05:36 +0100
User-Agent: KMail/1.5.3
References: <3F325198.2010301@namesys.com> <20030818202949.GD10320@matchmail.com> <20030818223946.182b0aab.skraw@ithnet.com>
In-Reply-To: <20030818223946.182b0aab.skraw@ithnet.com>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308182205.37071.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 Aug 2003 21:39, Stephan von Krawczynski wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> > "Comparing bitmaps.. vpf-10640: The on-disk and the correct bitmap
> > differs"
>
> Hm, but:
>
> "a and b differ"
> "a differs from b"

Yes.  Assuming that you're reporting the comparison of two single bitmaps:

"The on-disk bitmap and the correct bitmap differ."
"The on-disk and the correct bitmap differ."
"The on-disk bitmap differs from the correct bitmap."

I'd say the last of those three sounds best; the second sounds a little 
stilted because you have to think for a moment to realise that "on-disk" is 
being used as a contraction of "on-disk bitmap."

If the difference is between two sets of bitmaps:

"The on-disk bitmaps and the correct bitmaps differ."
"The on-disk and the correct bitmaps differ."
"The on-disk bitmaps differ from the correct bitmaps."

Matt (and that's the last you'll hear from me on this one; there's enough 
traffic on here as it is...)

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
