Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUANJfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUANJcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:32:45 -0500
Received: from main.gmane.org ([80.91.224.249]:41962 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265870AbUANJa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:30:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens@spamfreemail.de>
Subject: Re: 2.6.1mm2: nforce2 / amd74xx IDE driver doesn't load
Date: Wed, 14 Jan 2004 10:30:25 +0100
Organization: University of the Armed Forces, Hamburg, Germany
Message-ID: <bu327h$1t9$1@sea.gmane.org>
References: <2867040.OKCKYgd4AF@spamfreemail.de> <200401131756.03852.bzolnier@elka.pw.edu.pl> <bu1ccg$ouh$1@sea.gmane.org> <200401131924.51778.bzolnier@elka.pw.edu.pl> <1611511.Si9EDUbpBt@spamfreemail.de> <20040113214238.GZ9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>> >> PS: this worked in 2.4 (loading the IDE driver later as module, but
>> >> booting from IDE as well), why doesn't it work in 2.6 any more?
>> > 
>> > Because 2.6.x is different (most host drivers probe for drives
>> > themselves) and nobody fixed this issue :-).
>> 
>> Ok ... :) will reporting it here make somebody fix it for 2.6.2 or would
>> I need to file an official bug report on the kernel bugzilla website?
> 
> I don't think any of these two possibilities will fix it foor 2.6.2.
> The best way to get it fixed is most likely to send a patch that fixes
> it.  ;-)

Oh. I thought you were taking care of the dirty wo^W^Wpatch :-)


-- 
Jens Benecke (jens at spamfreemail.de)
http://www.hitchhikers.de - Europaweite kostenlose Mitfahrzentrale
http://www.spamfreemail.de - 100% saubere Postfächer - garantiert!
http://www.rb-hosting.de - PHP ab 9? - SSH ab 19? - günstiger Traffic

