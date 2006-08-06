Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWHFWIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWHFWIn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWHFWIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:08:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:4219 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750739AbWHFWIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:08:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m6BcoNMsjZC+w7jzX4PlHdPxIyLF0bBRn/mcMKWGzhdoSFiziQHU6Xdk1ki4uZZW6qrp/zvJmn0KcSNWOK4aK3ZdZqiHjUAAs6p4/grBjPLF5WPC1kJ2+Xe0RmQAF002iuIYP2lnk1r1syY41DJ1yskyBGqUaNu6b+BSkj+6u7s=
Message-ID: <41840b750608061508j9e731c4hf9de7b389c46c916@mail.gmail.com>
Date: Mon, 7 Aug 2006 01:08:40 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Cc: "Andrew Morton" <akpm@osdl.org>, rlove@rlove.org, khali@linux-fr.org,
       gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060806145551.GC30009@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492242899-git-send-email-multinymous@gmail.com>
	 <20060806005613.01c5a56a.akpm@osdl.org>
	 <41840b750608060256g1a7bb9c3s843d3ac08e512d63@mail.gmail.com>
	 <20060806030749.ab49c887.akpm@osdl.org>
	 <41840b750608060344p59293ce0xc75edfbd791b23c@mail.gmail.com>
	 <20060806145551.GC30009@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

Thanks for the explanation. Point taken, though I can't help parsing it as:

On 8/6/06, Theodore Tso <tytso@mit.edu> wrote:
> For legal reasons, we need a way to to contact and identify the author
> in the real world, not just in cyberspace, and a pseudonym doesn't
> meet that requirement.

"We want to be able to sue you if they sue us."

Which is actually not a problem for me (i.e., I don't believe I have
nothing to worry about legally); but I do have other, non-legal
considerations.


> just as the fact that we aren't requiring ink signatures and public notary
> checks doesn't mean we shouldn't stop doing what we are doing.

Understood, but still a bit silly. You have no idea how many of the
2252 people in `git-whatchanged | grep Signed-off-by: | sort | uniq`
gave their legal name, and I doubt you could contact most of them in
the real world without their cooperation (and with my cooperation, you
could contact me too). Heck, some of those email domains don't even
resolve. So this "chain of responsibiliy" is pretty worthless if
someone really tries to inject legally malicious code into mainline,
i.e., you end up blindly trusting people anyway.

BTW, Ted, we actually have met in person. :-)

  Shem
