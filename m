Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVHEWgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVHEWgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVHEWgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:36:43 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:40378 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S261896AbVHEWfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:35:00 -0400
Message-ID: <42F3E95B.4050704@keyaccess.nl>
Date: Sat, 06 Aug 2005 00:34:03 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <200506011643.42073.david-b@pacbell.net> <Pine.LNX.4.58.0506020316240.28167@artax.karlin.mff.cuni.cz> <200506011917.14678.david-b@pacbell.net> <429F075F.7030804@keyaccess.nl>
In-Reply-To: <429F075F.7030804@keyaccess.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

> David Brownell wrote:

>> Until I have some time available to actually look at this, all I can do
>> is answer questions and say "hmm, that's strange" given wierd facts.  The
>> wierdness here is why that "Async" status bit is ever getting set when
>> there's no work for it to do.
> 
> I'll be available for testing...
> 
> One more data point: I just checked 2.4.31 and it behaves the same.

Hi David. Has there been any progress on this issue?

(thread at http://marc.theaimsgroup.com/?t=111749614000002&r=1&w=2)

Rene.
