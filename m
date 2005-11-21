Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVKUH6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVKUH6T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 02:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVKUH6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 02:58:19 -0500
Received: from ihug-mail.icp-qv1-irony4.iinet.net.au ([203.59.1.198]:15546
	"EHLO ihug-mail.icp-qv1-irony4.iinet.net.au") by vger.kernel.org
	with ESMTP id S932203AbVKUH6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 02:58:18 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <43817E06.3040006@eyal.emu.id.au>
Date: Mon, 21 Nov 2005 18:57:58 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14.2: repeated oops in i810 init
References: <4380EB33.2060305@eyal.emu.id.au> <1132524526.22663.7.camel@mindpipe>
In-Reply-To: <1132524526.22663.7.camel@mindpipe>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2005-11-21 at 08:31 +1100, Eyal Lebedinsky wrote:
> 
>>I had this happen to me about three times, I captured it twice
>>using serial console [see logs at the bottom].
> 
> 
> Why would you use the old OSS driver?  It's scheduled to be removed from
> the kernel anyway.  What's wrong with the ALSA driver?

I know. It worked for me for about 10 years and I had no need to fix it
as it never broke. I know that soon it will be and I will have to figure
ALSA then.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
