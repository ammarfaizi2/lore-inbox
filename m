Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270415AbTGPIWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTGPIWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:22:16 -0400
Received: from [203.185.132.124] ([203.185.132.124]:26290 "EHLO mrchoke")
	by vger.kernel.org with ESMTP id S270415AbTGPIWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:22:06 -0400
Message-ID: <3F150E84.60209@opentle.org>
Date: Wed, 16 Jul 2003 15:36:20 +0700
From: Supphachoke Suntiwichaya <mrchoke@opentle.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030709
X-Accept-Language: th,en-us, en
MIME-Version: 1.0
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre6 + alsa 0.9.5 + i810 not work
References: <3F150561.5040903@opentle.org> <20030716081350.GA8976@eugeneteo.net>
In-Reply-To: <20030716081350.GA8976@eugeneteo.net>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Teo wrote:

>>Intel 810 + AC97 Audio, version 0.24, 11:19:13 Jul 16 2003
>>i810_rng: RNG not detected
>>    
>>
>
>Looks like the same specs as I have for Fujitsu E-7010.
>
>Have you tried choosing (Y), instead of compiling it as modules?
>
>// Intel ICH (i8xx), SiS 7012, NVidia nForce Audio or AMD 768/811x
>CONFIG_SOUND_ICH=y 
>
>  
>
hmm... I think if say y I can't use ALSA ?

MrChoke

>positive. It is the same one.
>
>Cheers,
>Eugene
>  
>


