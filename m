Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264868AbUEJQux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbUEJQux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264872AbUEJQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:50:53 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:40769 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S264868AbUEJQul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:50:41 -0400
Message-ID: <409FB2DA.4080703@blueyonder.co.uk>
Date: Mon, 10 May 2004 17:50:34 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 May 2004 16:50:42.0937 (UTC) FILETIME=[EEA75690:01C436AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Wrote:
Andrew Morton wrote:
 > >/ make-4k-stacks-permanent.patch/
 > >/ make 4k stacks permanent/

 > I've reverted this one (nvidia crash blah blah...) but I still can't 
get a
 > working system. The box just sits there doing -apparently- nothing.
 >
 > Which other patch{,es} am I missing?

 > Best regards,
 > Norberto
I have had 2 serious hard disk problems with the 4KSTACKS patch 
installed, once through ignorance and once when I plain forgot and had 
only checked that it wasn't on in my .config.
The first disk failed to boot up fully, it just hung somewhere in init, 
but I could get at the files, the second one was dead, I had to do a 
fresh format/install, reiserfsck /debugreiserfs could not repair either 
of them. It's a dangerous patch.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

