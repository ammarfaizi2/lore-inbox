Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTFBWYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 18:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTFBWYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 18:24:10 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:49751 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S264188AbTFBWYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 18:24:09 -0400
Date: Tue, 3 Jun 2003 00:37:11 +0200
Message-Id: <200306022237.h52MbBJD009436@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Slocate/backup, big load on 2.4.X
In-Reply-To: <5.2.1.1.0.20030529070827.03f6c290@oceanic.wsisiz.edu.pl>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: 87 9F 39 9C F9 EE EA 7F  8F C9 58 6A D4 54 0E B9
X-Key-ID: 6DB9C699
User-Agent: tin/1.5.18-20030602 ("Darts") (UNIX) (Linux/2.4.21-rc4 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <5.2.1.1.0.20030529070827.03f6c290@oceanic.wsisiz.edu.pl> you wrote:
> At 01:03 2003-05-29, Andrew Morton wrote:
>> > After 12 hours of reboot, when updatedb is running or backup via amanda,
>> > system "get" very high load,
>>
>>High load isn't necesarily a problem - it just means that a lot of
>>processes are waiting on disk I/O.  Because updatedb is flogging the disks.
> 
> For me it is problem because whole machine "freezes" (no reaction on 
> anything) for 2-3 minutes.... - and after 2-3 minutes it has load about 
> 50-100 - I think that it has higher load (>100) when it "freezes" then 
> after next 2-3 minutes situation repeates....

No one know what's up with it? It stil appears in 2.4.21-rc6. How to fix it?
We can't do backups :(

-- 
*[ £ukasz Tr±biñski ]*
