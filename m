Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWAQRxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWAQRxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWAQRxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:53:05 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:30450 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932137AbWAQRxE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:53:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qSULyeFlTGXajEt2For4nT4zXIKeJySuqnBy43FBGfFQiYPaCYgE4zlRKvqim5wWQNoBN+9GKzntFNBUU8Qm1td+lb9SOvWDFRNbkBXENWJ0sLkrUACCvcTxzvdr04Enx3kLnMpVRsDbKNo07c7rU4khkAgx9IDsadw2z+jcbxo=
Date: Tue, 17 Jan 2006 18:52:44 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: mkrufky@m1k.net, webmaster@kernel.org, linux-kernel@vger.kernel.org,
       mkrufky@gmail.com
Subject: Re: [KORG] GITWEB doesn't show any DIFF's
Message-Id: <20060117185244.e7b5cffc.diegocg@gmail.com>
In-Reply-To: <200601171739.17168.s0348365@sms.ed.ac.uk>
References: <43CCF8BB.1050009@m1k.net>
	<200601171739.17168.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 17 Jan 2006 17:39:17 +0000,
Alistair John Strachan <s0348365@sms.ed.ac.uk> escribió:

> Seems to work for me right _now_, could you verify that this is still 
> happening?


It happens for me, too - instead of showing me the diff, diffstat
shows me just:


file:844a6c9fb9490e585fc5371d759840b9e7ae327c -> file:21965e5ef25e8c1c86bd59da0f40350d4f821702
file:9a96f05883935a32955b216fcc3184bf162b0a85 -> file:63dd184ec808e7129efc3a355abdba4a21bf2c81

With this commitdiff link, for example: 
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7fab773de16ccaeb249acdc6e956a9759c68225d;hp=0046b06a367cd853efd3223ce60143f3a7952522
