Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTJAIiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTJAIiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:38:14 -0400
Received: from play.smurf.noris.de ([192.109.102.42]:36743 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S261687AbTJAIiN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:38:13 -0400
From: Matthias Urlichs <smurf@smurf.noris.de>
Organization: {M:U}
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] No forced rebuilding of ikconfig.h
Date: Wed, 1 Oct 2003 10:37:58 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20030929153815.GA16685@play.smurf.noris.de> <20030929092952.7ba7b1c0.rddunlap@osdl.org>
In-Reply-To: <20030929092952.7ba7b1c0.rddunlap@osdl.org>
X-Face: xyzzy
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310011037.58929@smurf.noris.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Randy.Dunlap wrote:
> | Why does ikconfig.h require forced rebuilding?
> | I can't think of a reason...
>
> Would you describe the problem, if any?

It was rebuilding every time.

> Since I removed linux/compile.h and linux/version.h from
> kernel/configs.c (as in -test6), I don't see any rebuilding
> happening.  When does it happen?
>
Ah. Thank you.

> Also, what kernel version are you referring to???

*Sigh* I am sorry I forgot that. I really should know better.  :-/

Since it works now, the correct answer to that one seems to be "sometime 
before -test6".

You know the joke where the Jewish father berates his son for using too many 
words in a telegram... well, seems I need to learn not to do that.  :-(

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Your parentheses always match.

