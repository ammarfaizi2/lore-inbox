Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUH0UOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUH0UOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267514AbUH0UNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:13:40 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:19723 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S267526AbUH0UHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:07:06 -0400
Message-Id: <6.1.2.0.2.20040827215143.01d7b038@inet.uni2.dk>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.2.0
Date: Fri, 27 Aug 2004 22:06:29 +0200
To: Linus Torvalds <torvalds@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
From: Kenneth Lavrsen <kenneth@lavrsen.dk>
Subject: Re: pwc+pwcx is not illegal
Cc: pmarques@grupopie.com, greg@kroah.com, nemosoft@smcc.demon.nl,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0408271226400.14196@ppc970.osdl.org>
References: <1093634283.431.6370.camel@cube>
 <Pine.LNX.4.58.0408271226400.14196@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:29 2004-08-27, Linus Torvalds wrote:

>Can we drop this straw-man discussion now?
>
>We don't do binary hooks in the kernel. Full stop. It's a gray area
>legally (and whatever you say won't change that), but it's absolutely not
>gray from a distribution standpoint.
>
>AND IT WASN'T EVER THE REASON FOR REMOVING THE DRIVER IN THE FIRST PLACE!
>
>So stop whining about it. The driver got removed because the author asked
>for it.
>
>                 Linus

Try and see this from the developers perspective and then remember that he 
is a human beeing.

When I look at the postings from the past months I would say that he was 
provoked to react the way he did by the arrogant way that Greg handled it.
And from what Greg says himself that people has called him in the past (I 
will not repeat it) I would advice Greg to consider changing behavour.
Because this is what it all comes down to.
Why did Nemosoft react to hard?
When you love what you are doing and you have worked hard - not for your 
own good - but to help others - it is hard to repeatedly being treated 
badly. And there should be no need to in the open source community.

I agree that the right way to go is to get all drivers open source. And I 
think it is OK to reject new drivers.
But accepting a hook that allows a driver to use an external binary module 
for years and then suddenly remove this without making sure that it is 
replaced with something better is just plain wrong because it harms a lot 
of people.

Just look at the reaction everywhere. I have rarely seen so many angry 
Linux users. I have already started contacting computer magazines and news 
papers. I just cannot accept that people can care so little for other people.

Kenneth


-- 
Kenneth Lavrsen,
Glostrup, Denmark
kenneth@lavrsen.dk
Home Page - http://www.lavrsen.dk 


