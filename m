Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291077AbSBGX7g>; Thu, 7 Feb 2002 18:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291090AbSBGX70>; Thu, 7 Feb 2002 18:59:26 -0500
Received: from otter.mbay.net ([206.40.79.2]:23813 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S291077AbSBGX7R> convert rfc822-to-8bit;
	Thu, 7 Feb 2002 18:59:17 -0500
From: John Alvord <jalvo@mbay.net>
To: Mike Touloumtzis <miket@bluemug.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Date: Thu, 07 Feb 2002 15:58:51 -0800
Message-ID: <q3566uskjs1g7fcts5uq07boleet2641ka@4ax.com>
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <E16Yu52-00015I-00@starship.berlin> <20020207203451.GE26826@bluemug.com> <E16YvYs-00015d-00@starship.berlin> <20020207210823.GH26826@bluemug.com>
In-Reply-To: <20020207210823.GH26826@bluemug.com>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002 13:08:23 -0800, Mike Touloumtzis
<miket@bluemug.com> wrote:

>On Thu, Feb 07, 2002 at 09:54:30PM +0100, Daniel Phillips wrote:
>> On February 7, 2002 09:34 pm, Mike Touloumtzis wrote:
>> > Some possible available avenues of argument for you are:
>> 
>> I think you're just arguing for the sake of argument, which basically sums
>> up all the arguments we've seen against this.
>
>Not at all.  I really believe that embedded unnecessary information in
>the kernel is a bad idea.  I don't want my kernels to get any bigger
>than they are now unless useful features are being added (I have no
>problem with that).  I develop for embedded devices, so I'm particularly
>sensitive to this issue.
>
>My understanding is that "keep features out of the kernel if possible"
>is the majority opinion, not a crackpot weirdo stance.
>
>> Let me put it in simple terms: you've got an alarm clock, haven't you?  When 
>> you set the alarm, you don't need to have any little light on the front that 
>> tells you the alarm is set, do you?  Because, after all you're not stupid, 
>> you know you set it.  And you can always get out of bed and look at the 
>> position of the switch, right?
>
>I don't think this is a close enough analogy to illustrate anything.
>The examples I chose to illustrate my points were IMHO closely related
>software packaging issues.

An often heard argument is "can it be done in user space", which seems
very applicable here.

john alvord
