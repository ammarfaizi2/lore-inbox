Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSFDTmB>; Tue, 4 Jun 2002 15:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316635AbSFDTmA>; Tue, 4 Jun 2002 15:42:00 -0400
Received: from h00045ad915fa.ne.client2.attbi.com ([24.60.112.15]:60367 "HELO
	frank.mercea.net") by vger.kernel.org with SMTP id <S315277AbSFDTl7>;
	Tue, 4 Jun 2002 15:41:59 -0400
Mime-Version: 1.0
Message-Id: <a05111701b922c72cb2c9@[10.1.0.123]>
In-Reply-To: <20020604192145.65B5C28D41@russian-caravan.cloud9.net>
Date: Tue, 4 Jun 2002 15:42:35 -0400
To: "Stephane Charette" <scharette@packeteer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Brett Dikeman <brett@cloud9.net>
Subject: Re: 2.4.18 assertion failure in journal_commit_transaction
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:21 PM -0700 6/4/02, Stephane Charette wrote:

>Didn't RH 2.4.18-4 fix an ext3 bug on SMP?
>
>http://rhn.redhat.com/errata/RHBA-2002-085.html
>
>Is this related to what you saw?

Yep, I'd say that covers it pretty well.  Lesson learned: rpm 
changenotes are pretty worthless for quickly figuring out what was 
fixed from the perspective of someone who does not follow what the 
various patches encompass/fix.

Thanks for the quick(and helpful!) reply, Stephane.  Earns the award 
for Most Diplomatic, too :-)

Sorry for the waste of time/space/bandwidth, folks!  Thought I had 
done my homework on this one(hey, I even read the bug-reporting faqs 
:-)

Brett
-- 
----
"They that give up essential liberty to obtain temporary
safety deserve neither liberty nor safety." - Ben Franklin

