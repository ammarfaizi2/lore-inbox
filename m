Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276704AbRJBVdd>; Tue, 2 Oct 2001 17:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276707AbRJBVdY>; Tue, 2 Oct 2001 17:33:24 -0400
Received: from [194.213.32.137] ([194.213.32.137]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S276704AbRJBVdJ>;
	Tue, 2 Oct 2001 17:33:09 -0400
Message-ID: <20011002221059.E140@bug.ucw.cz>
Date: Tue, 2 Oct 2001 22:10:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org
Cc: riel@conectiva.com.br, andrea@suse.de
Subject: Re: Cache-Opt Skip List & Red-Black Tree
In-Reply-To: <20011001145906.A3616@helen.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20011001145906.A3616@helen.CS.Berkeley.EDU>; from Josh MacDonald on Mon, Oct 01, 2001 at 02:59:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Are there applications out there that use 1000s or 10000s of
> vm_area_struct mappings?  I would be curious to know.

Try efence with gcc... That's probably as bad as it can get.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
