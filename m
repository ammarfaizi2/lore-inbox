Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266898AbUAXJ7V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 04:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266900AbUAXJ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 04:59:21 -0500
Received: from main.gmane.org ([80.91.224.249]:30432 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266898AbUAXJ7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 04:59:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: pmdisk working on ppc
Date: Sat, 24 Jan 2004 10:59:17 +0100
Message-ID: <yw1xllnx7jm2.fsf@ford.guide>
References: <20040119105237.62a43f65@localhost> <1074483354.10595.5.camel@gaston>
 <1074489645.2111.8.camel@laptop-linux> <1074490463.10595.16.camel@gaston>
 <1074534964.2505.6.camel@laptop-linux> <1074549790.10595.55.camel@gaston>
 <20040122211746.3ec1018c@localhost> <1074841973.974.217.camel@gaston>
 <20040123183030.02fd16d6@localhost> <1074919185.814.82.camel@gaston>
 <20040124072007.GA233@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:zzrr18RFo97IMPhWe37yuak3M2Y=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> (RESENT, sorry if you got it already, something apparently went wrong
>> on the SMTP here)
>>
>> Ok, I hammered that for a day and got pmdisk (patrick's version) suspending
>> and resuming on a pismo G3 (with XFree etc.. running). Lots of rough
>> edges
>
> Congratulations!
> 								Pavel
> [Now we'll have to do something with pmdisk vs. swsusp...]

pmdisk is the only one that ever was close to working on my laptop, do
don't kill that one.  Some driver is (was?) preventing it from
resuming properly.  Is there some list somewhere of drivers known to
be pmdisk safe?

-- 
Måns Rullgård
mru@kth.se

