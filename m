Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292384AbSBBVDL>; Sat, 2 Feb 2002 16:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292385AbSBBVDB>; Sat, 2 Feb 2002 16:03:01 -0500
Received: from [195.63.194.11] ([195.63.194.11]:54277 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292384AbSBBVC6>; Sat, 2 Feb 2002 16:02:58 -0500
Message-ID: <3C5C53F5.1030401@evision-ventures.com>
Date: Sat, 02 Feb 2002 22:02:45 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020129
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: David Wagner <daw@mozart.cs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com> <a3fhh9$u87$1@abraham.cs.berkeley.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:

>Peter Monta  wrote:
>
>>Many motherboards have on-board sound.  Why not turn the mic
>>gain all the way up and use the noise---surely there will be
>>a few bits' worth?
>>
>
>That may be reasonable, but beware: there are some potential pitfalls.
>For instance, is there a risk that the audio data you read is strongly
>correlated to 60Hz mains noise in some scenarios?  Also, my understanding
>is that the quality of randomness you get can depend on which sound card
>you have, and moreover that the left and right channels can be strongly
>correlated (audio-entropyd takes the difference between the two).
>I think there are some things you can do, but it seems that one might
>want to be a bit careful here.
>
There is no need to speculate here - just please do aan autocorrelation 
of the signal with grace for example and
laugh at the idea ;-).


