Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVJSR4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVJSR4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJSR4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:56:40 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:23564 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751197AbVJSR4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:56:39 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: John Richard Moser <nigelenki@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: When is OSS going to go?
References: <43553887.4020305@comcast.net> <43556E2E.7090102@tmr.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: the Swiss Army of Editors.
Date: Wed, 19 Oct 2005 18:56:30 +0100
In-Reply-To: <43556E2E.7090102@tmr.com> (Bill Davidsen's message of "18 Oct
 2005 22:50:16 +0100")
Message-ID: <87mzl5ie5t.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Oct 2005, Bill Davidsen suggested tentatively:
> John Richard Moser wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>> The Open Sound System has been depricated. . . since. . . when the heck?
>>  2.4?  Is it ever going to drop off?  Are there a few cards in OSS that
>> don't work right in ASLA?
>>
> This has been discussed before, but the major argument is that if
> Linux starts dropping functional features there is no longer even a
> pretense of this kernel line being stable.

The dropping of e.g. devfs has already knocked that idea on the head;
functional features are being removed as well as added.

(And as ALSA can emulate the useful parts of OSS, when all OSS cards are
supported by ALSA, there won't be any function loss anyway.)

-- 
`"Gun-wielding recluse gunned down by local police" isn't the epitaph
 I want. I am hoping for "Witnesses reported the sound up to two hundred
 kilometers away" or "Last body part finally located".' --- James Nicoll
