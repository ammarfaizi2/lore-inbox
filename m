Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbRFGKQh>; Thu, 7 Jun 2001 06:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264386AbRFGKQ1>; Thu, 7 Jun 2001 06:16:27 -0400
Received: from zeus.kernel.org ([209.10.41.242]:50406 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262421AbRFGKQJ>;
	Thu, 7 Jun 2001 06:16:09 -0400
Message-ID: <3B1F51DB.54BE78CA@iph.to>
Date: Thu, 07 Jun 2001 13:05:15 +0300
From: Philips <philips@iph.to>
Organization: Enformatica Ltd. UK
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
In-Reply-To: <20010606155026.A28950@bug.ucw.cz> <B74421C0.F6F7%bootc@worldnet.fr> <20010606224203.A2044@atrey.karlin.mff.cuni.cz> <20010606235213.C1136@werewolf.able.es>
Content-Type: multipart/mixed;
 boundary="------------5195CADA6EA02E183D529ED5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5195CADA6EA02E183D529ED5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello All!

	Kelvins good idea in general - it is always positive ;-)

	0.01*K fits in 16 bits and gives reasonable range.

	but may be something like K<<6 could be a option? (to allow use of shifts
instead of muls/divs). It would be much more easier to extract int part.

	just my 2 eurocents.
--------------5195CADA6EA02E183D529ED5
Content-Type: text/x-vcard; charset=us-ascii;
 name="philips.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Philips
Content-Disposition: attachment;
 filename="philips.vcf"

begin:vcard 
n:Filiapau;Ihar
tel;pager:+375 (0) 17 2850000#6683
tel;fax:+375 (0) 17 2841537
tel;home:+375 (0) 17 2118441
tel;work:+375 (0) 17 2841371
x-mozilla-html:TRUE
url:www.iph.to
org:Enformatica Ltd.;Linux Developement Department
adr:;;Kalinine str. 19-18;Minsk;BY;220012;Belarus
version:2.1
email;internet:philips@iph.to
title:Software Developer
note:(none)
x-mozilla-cpt:;18368
fn:Philips
end:vcard

--------------5195CADA6EA02E183D529ED5--

