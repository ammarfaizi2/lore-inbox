Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbTJCSYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 14:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbTJCSYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 14:24:30 -0400
Received: from mail.midmaine.com ([66.252.32.202]:35534 "HELO
	mail.midmaine.com") by vger.kernel.org with SMTP id S263821AbTJCSYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 14:24:00 -0400
To: Tomasz Rola <rtomek@cis.com.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CMD680, kernel 2.4.21, and heartache
X-Eric-Conspiracy: There Is No Conspiracy
References: <Pine.LNX.3.96.1031003200237.19402A-100000@pioneer.space.nemesis.pl>
From: Erik Bourget <erik@midmaine.com>
Date: Fri, 03 Oct 2003 14:22:58 -0400
In-Reply-To: <Pine.LNX.3.96.1031003200237.19402A-100000@pioneer.space.nemesis.pl> (Tomasz
 Rola's message of "Fri, 3 Oct 2003 20:10:03 +0200 (CEST)")
Message-ID: <87k77m89kt.fsf@loki.odinnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Rola <rtomek@cis.com.pl> writes:

> On Fri, 3 Oct 2003, Erik Bourget wrote:
>
>> Erik Bourget <erik@midmaine.com> writes:
>> 
>> (194)Temperature             0x0002   196   196   000       1441854
>
> You should definitely take a look at other drives data in all computers,
> esp. temperature. Consult this with max allowed temperature as defined by
> hd manufacturer for this specific type of the drive (should be somewhere
> on their website or on google). Each disk is different but the general
> safe bet for a limit is 40-45 oC, from what I know.
>
> Your room may be cool but it's better to check.
>
> bye
> T.

Yeah, it says 196, and that's bizarre.  196 whats?  From looking at other
example output, the '1441854' number is usually the true deg. C of the
machine.  But I'm reasonably sure that it's not at a million and a half
centigrade.

I can open the case up and put my hand on the drive.  It feels cooler to the
touch than the 10k SCSI drives in the next machine over...

Thanks though;

Erik

