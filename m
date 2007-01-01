Return-Path: <linux-kernel-owner+w=401wt.eu-S1753664AbXAAJmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbXAAJmO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 04:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbXAAJmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 04:42:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:54364 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbXAAJmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 04:42:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:references:in-reply-to:disposition-notification-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dxxgYGn1cTpCMQyFmDvloNEUgUO9MpUyhttxvJRfudvYetS88/jsISJognngPaqKsfMojO6fmO7a+mpA3FJa/fR98TU++Xt0XX9SGExXMLMOdQptrutypPS+VbTHAvPgU0uXeV1391gV+sv+zm0bxjOecHOPwlKO1S+nsywrgck=
From: "Cyrill V. Gorcnov" <gorcunov@gmail.com>
Reply-To: gorcunov@gmail.com
To: Petr Vandrovec <vandrove@vc.cvut.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
Date: Mon, 1 Jan 2007 12:41:02 +0300
User-Agent: KMail/1.9.5
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <200701011022.54336.gorcunov@gmail.com> <4598BC0F.6070003@vc.cvut.cz>
In-Reply-To: <4598BC0F.6070003@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701011241.03076.gorcunov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 January 2007 10:45, you wrote:
|  Cyrill V. Gorcnov wrote:
|  > On Monday 01 January 2007 04:19, you wrote:
|  > |  
|  > |  In order to not get in trouble with MADR ("Mothers Against Drunk 
|  > |  Releases") I decided to cut the 2.6.20-rc3 release early rather than wait 
|  > |  for midnight, because it's bound to be new years _somewhere_ out there. So 
|  > |  here's to a happy 2007 for everybody.
|  > |  
|  > 
|  > I've tried to clone linux git repo and got:
|  > 
|  > 	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
|  > 	fatal: unexpected EOF
|  > 	fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.
|  > 
|  > What's wrong?
|  
|  I think that git does not like year rollover.  I've tried it after Linus 
|  sent message out, and it was not giving me anything new (cca from 5PM 
|  PST when Linus sent change to 8PM).  Then it gave out random changes 
|  (8PM to 9PM).  After that it was dead, as you've noticed.  But after 
|  that I was able to get 2.6.20-rc3 out - compiling now.   So perhaps just 
|  try it again...
|  								Petr
|  
|  P.S.: Happy New Year.  Here in California we still have 15 minutes of 
|  year 2006 to go.
|  
|  
|  

Yea, I've got linux git clone later. I think that was some files activity
on git server so that is why I was noticed with "fatal: unexpected EOF" git
message.

-- 
	- Cyrill
