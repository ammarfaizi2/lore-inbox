Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVIUQL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVIUQL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVIUQL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:11:28 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:61703 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751112AbVIUQL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:11:27 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] Add dm-snapshot tutorial in Documentation
References: <20050920184513.14557.8152.stgit@zion.home.lan>
	<874q8f5qw1.fsf@amaterasu.srvr.nix>
	<200509211704.15364.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
X-Emacs: Lovecraft was an optimist.
Date: Wed, 21 Sep 2005 17:11:17 +0100
In-Reply-To: <200509211704.15364.blaisorblade@yahoo.it> (blaisorblade@yahoo.it's
 message of "Wed, 21 Sep 2005 17:04:14 +0200")
Message-ID: <87mzm61jve.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, blaisorblade@yahoo.it spake:
> On Wednesday 21 September 2005 00:13, Nix wrote:
>> On 20 Sep 2005, Paolo Giarrusso docced:
>> > +When you create a LVM* snapshot of a volume, four dm devices are used:
>>
>> [...]
>>
>> > +* I've verified this with LVM 2.01.09, however I assume this is the LVM2
>> > way +  of doing this.
> 
>> Yes; LVM1 doesn't use device-mapper at all, so these docs don't apply to
>> it.
> I really meant "I assume that all LVM2 releases work this way".

As far as I know they do, modulo bugs, although if you go back far enough
device-mapper doesn't have support for snapshots at all.

-- 
`One cannot, after all, be expected to read every single word
 of a book whose author one wishes to insult.' --- Richard Dawkins
