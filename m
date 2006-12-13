Return-Path: <linux-kernel-owner+w=401wt.eu-S964901AbWLMM1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWLMM1U (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWLMM1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:27:19 -0500
Received: from mbx.ines.ro ([80.86.96.25]:47447 "EHLO mailbox.ines.ro"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964901AbWLMM1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:27:19 -0500
X-Greylist: delayed 10934 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 07:27:18 EST
Subject: Re: Postgrey experiment at VGER
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@ines.ro>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061212235056.GP10054@mea-ext.zmailer.org>
References: <20061212235056.GP10054@mea-ext.zmailer.org>
Content-Type: text/plain
Organization: iNES Group
Date: Wed, 13 Dec 2006 11:25:02 +0200
Message-Id: <1166001902.15211.4.camel@DustPuppy.LNX.RO>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Milter 1.6.2 on MailBox.iNES.RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 01:50 +0200, Matti Aarnio wrote:
> I do already see spammers smart enough to retry addresses from
> the zombie machine, but that share is now below 10% of all emails.
> My prediction for next 200 days is that most spammers get the clue,
> but it gives us perhaps 3 months of less leaked junk.

IMHO this is only an step in an "arms race".
What you will do in three months, remove this check because it will
prove useless since the spammers will also retry ? If yes, why install
it in the first place ? 


-- 
Cioby

Opinions expressed do not belong to any company.
I'm not sure they belong to me either.


