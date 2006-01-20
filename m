Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161325AbWATHEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161325AbWATHEe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 02:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161332AbWATHEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 02:04:34 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:51575 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161325AbWATHEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 02:04:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=kYSzCBCfn1hkATGCe56oRBh2o3W12jPULMuqoFYJEO6t41bL5ti3n1qjzjdnbiPDhBiSG1FOvkFoOF8TrfaGQqQmLcXRWTsZDnSvnCWwdTs6F11vwEwa2yoSIIhmDa096X5ANCMu2H13h0l4JDo6ucd5LyggpSNWpugnZelRIyo=  ;
In-Reply-To: <43D05D0C.1030900@keyaccess.nl>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <43D05D0C.1030900@keyaccess.nl>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0D5E76A0-FA1B-4CCC-BFA6-D84FBA1EE39D@yahoo.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Content-Transfer-Encoding: 7bit
From: Brent Cook <busterbcook@yahoo.com>
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different approach
Date: Fri, 20 Jan 2006 01:04:30 -0600
To: Rene Herman <rene.herman@keyaccess.nl>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 19, 2006, at 9:46 PM, Rene Herman wrote:

> Krzysztof Halasa wrote:
>
>>> SOUND_ADLIB
>> IIRC 8-bit sound, ISA. GUS on DOS used to emulate it
>
> Extremely classic card. Would be fun to still have around if only  
> for history's sake...

The Adlib card that I had was just an OPL-2 synthesizer, no PCM  
support at all. Normally, it was mono, 9 voices, 2 FM operators per  
voice + 3 noise channels, but there was a mode that supported 4  
operators and reduced the number of voices to 4 or 5.

An OPL-3 is just 2 OPL-2's, one for each stereo channel. I think that  
any card with an OPL-3 (SB-16) can act like an OPL-2, i.e. would be  
suitable for porting the driver. I really wish I still had my  
old .rol and .pat file collection; had a killer version of Bohemian  
Rhapsody.
