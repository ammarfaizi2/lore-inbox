Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVADFbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVADFbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 00:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVADFbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 00:31:07 -0500
Received: from simmts12.bellnexxia.net ([206.47.199.141]:31166 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261540AbVADFbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 00:31:01 -0500
Message-ID: <38859.10.10.10.28.1104816566.squirrel@linux1>
In-Reply-To: <crd864$bkp$1@sea.gmane.org>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com>
    <20050103003011.GP29332@holomorphy.com>
    <20050103004551.GK4183@stusta.de>
    <20050103011935.GQ29332@holomorphy.com>
    <20050103053304.GA7048@alpha.home.local>
    <20050103123325.GV29332@holomorphy.com>
    <20050103213845.GA18010@alpha.home.local>
    <crd864$bkp$1@sea.gmane.org>
Date: Tue, 4 Jan 2005 00:29:26 -0500 (EST)
Subject: Re: starting with 2.7
From: "Sean" <seanlkml@sympatico.ca>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-7
X-Mailer: SquirrelMail/1.4.3a-7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, January 4, 2005 12:06 am, Alexander E. Patrakov said:
> Willy Tarreau wrote:
>
>> I feel they're brave. I know several other people who went back, either
>> because they didn't feel comfortable with upgrades these size, which
>> sometimes did not boot because of random patches, or simply because of
>> the
>> scheduler which didn't let them type normally in an SSH session on a
>> CPU-bound system, or even a proxy which performance dropped by a factor
>> of
>> 5 between 2.4 and 2.6. I know they don't report it, but they are not
>> developpers. They see that 2.6 is not ready yet, and turn back to stable
>> 2.4.
>
> Here is one more regression report.
>
> My /home was on reiserfs some time ago (migrated to ext3 using convertfs
> due
> to this regression). I read my mail with KMail. I am also subscribed to
> several mailing lists. I have a separate Maildir-formatted folder for each
> mailing list. Some of such folders are more than a year old and contain
> thousands of messages. With linux-2.4, I could click on such folder and
> the
> list of messages sorted by subject will appear in KMail almost instantly.
> With linux-2.6, this process takes much longer.
>

Which might just indicate that the old development model under which the
2.6 kernel was developed wasn't ideal.   Perhaps you wouldn't be having
this problem had the new development model been in place sooner.

Sean


