Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291291AbSBGVJE>; Thu, 7 Feb 2002 16:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291308AbSBGVIt>; Thu, 7 Feb 2002 16:08:49 -0500
Received: from barbados.bluemug.com ([63.195.182.101]:266 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S291291AbSBGVI2>; Thu, 7 Feb 2002 16:08:28 -0500
Date: Thu, 7 Feb 2002 13:08:23 -0800
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020207210823.GH26826@bluemug.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <E16Yu52-00015I-00@starship.berlin> <20020207203451.GE26826@bluemug.com> <E16YvYs-00015d-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16YvYs-00015d-00@starship.berlin>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 09:54:30PM +0100, Daniel Phillips wrote:
> On February 7, 2002 09:34 pm, Mike Touloumtzis wrote:
> > Some possible available avenues of argument for you are:
> 
> I think you're just arguing for the sake of argument, which basically sums
> up all the arguments we've seen against this.

Not at all.  I really believe that embedded unnecessary information in
the kernel is a bad idea.  I don't want my kernels to get any bigger
than they are now unless useful features are being added (I have no
problem with that).  I develop for embedded devices, so I'm particularly
sensitive to this issue.

My understanding is that "keep features out of the kernel if possible"
is the majority opinion, not a crackpot weirdo stance.

> Let me put it in simple terms: you've got an alarm clock, haven't you?  When 
> you set the alarm, you don't need to have any little light on the front that 
> tells you the alarm is set, do you?  Because, after all you're not stupid, 
> you know you set it.  And you can always get out of bed and look at the 
> position of the switch, right?

I don't think this is a close enough analogy to illustrate anything.
The examples I chose to illustrate my points were IMHO closely related
software packaging issues.

miket
