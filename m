Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUAaX2B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 18:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbUAaX2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 18:28:00 -0500
Received: from server.logic.univie.ac.at ([131.130.190.41]:17557 "EHLO
	server.logic.univie.ac.at") by vger.kernel.org with ESMTP
	id S265211AbUAaX1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 18:27:48 -0500
Date: Sun, 1 Feb 2004 00:11:08 +0100
From: Andreas Metzler <lkml-2004-01@downhill.at.eu.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.25-pre4
Message-ID: <20040131231108.GA4481@downhill.at.eu.org>
References: <1b0nY-2vi-13@gated-at.bofh.it> <1b3OA-7FV-17@gated-at.bofh.it> <1b4hG-8kh-21@gated-at.bofh.it> <20040130135730.GB1215@balrog.logic.univie.ac.at> <1075475962.18944.0.camel@midux> <Pine.LNX.4.58L.0401312035080.4252@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58L.0401312035080.4252@logos.cnet>
X-GPG-Fingerprint: BCF7 1345 BE42 B5B8 1A57  EE09 1D33 9C65 8B8D 7663
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 08:47:32PM -0200, Marcelo Tosatti wrote:
> On Fri, 30 Jan 2004, Markus Hästbacka wrote:
>> On Fri, 2004-01-30 at 15:57, Andreas Metzler wrote:
>>> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>>>> On Tue, 6 Jan 2004, Mike Fedyk wrote:
>>>>> On Tue, Jan 06, 2004 at 12:14:23PM -0200, Marcelo Tosatti wrote:
>>>>>> It contains an ext2/3 update (mostly forward compatibility
>>>>>> related), the

>>>>> Do you plan to merge htree?

>>>> Yes, in the next -pre.

>>> Hm. Afaict this has not happened yet (-pre8), is it still planned for
>>> .25?

>> I think he meant for the 2.4.26-pre tree.

> And it wont happen anymore. After saying that I would merge it, I decided
> (based on input from sct and tytso) that we don't want htree in 2.4.x.

Ok. Looks like I will have to switch to 2.6 some time. ;-) Thanks for the
information (and all the work).
          cu andreas
