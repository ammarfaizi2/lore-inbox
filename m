Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVAHW3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVAHW3v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVAHW32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:29:28 -0500
Received: from hermes.domdv.de ([193.102.202.1]:45067 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262028AbVAHW2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:28:11 -0500
Message-ID: <41E05E6B.4080500@domdv.de>
Date: Sat, 08 Jan 2005 23:27:55 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: ross@lug.udel.edu, "Jack O'Quin" <joq@io.com>,
       Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501071620.j07GKrIa018718@localhost.localdomain>	 <1105132348.20278.88.camel@krustophenia.net>	 <20050107134941.11cecbfc.akpm@osdl.org>	 <20050107221059.GA17392@infradead.org>	 <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us>	 <20050108165657.GA21760@jose.lug.udel.edu> <1105222819.24592.131.camel@krustophenia.net>
In-Reply-To: <1105222819.24592.131.camel@krustophenia.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2005-01-08 at 11:56 -0500, ross@lug.udel.edu wrote:
> 
>>Not to mention that not everyone chooses to use PAM for precisely this
>>reason.  Slackware has never included PAM and probably never will.
>>My audio workstation has worked swell with the 2.4+caps solution and
>>the 2.6+LSM solution.  PAM would break me ::-(
> 
> 
> Hmm.  How could you (for example) configure all your machines to
> authenticate against an LDAP server without PAM?

nss_ldap :-)

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
