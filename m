Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290244AbSAOSmr>; Tue, 15 Jan 2002 13:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290245AbSAOSmk>; Tue, 15 Jan 2002 13:42:40 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:52686 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290238AbSAOSlL>; Tue, 15 Jan 2002 13:41:11 -0500
To: "Martin Eriksson" <nitrax@giron.wox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why not "attach" patches?
In-Reply-To: <005901c19dec$59a89e30$0201a8c0@HOMER>
From: Andi Kleen <ak@muc.de>
Date: 15 Jan 2002 19:39:40 +0100
In-Reply-To: "Martin Eriksson"'s message of "Tue, 15 Jan 2002 18:50:15 +0100"
Message-ID: <m3wuyjjw5v.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin Eriksson" <nitrax@giron.wox.org> writes:

> Why do many of you not _attach_ patches instead of merging them with the
> mail? It's so much cleaner and easier to have a "xxx-yyy.patch" file
> attached to the mail which can be saved in an appropriate directory. Also,
> the whitespace is always retained that way.
> 
> OTOH I don't have very deep knowledge of "diff" and "patch", so maybe I have
> missed something here...

Patches are often saved and applied later. In this case it is useful to have
the context of the mail message it was contained in around in the same 
file, so that you later actually know what you apply if you happen to 
not memorize it completely. Patch will ignore the mail part so it can be 
still applied directly.

With saved attachments you usually just a patch and no description, or 
it requires extra effort to save the description too. 

-Andi
