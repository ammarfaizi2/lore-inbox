Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285663AbRLGXdH>; Fri, 7 Dec 2001 18:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285659AbRLGXc5>; Fri, 7 Dec 2001 18:32:57 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:775 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285661AbRLGXcp>;
	Fri, 7 Dec 2001 18:32:45 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Robert Love <rml@tech9.net>
Cc: linux-ia64@linuxia64.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre6 drm-4.0 
In-Reply-To: Your message of "07 Dec 2001 18:27:11 CDT."
             <1007767634.12114.0.camel@phantasy> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 10:32:33 +1100
Message-ID: <4719.1007767953@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Dec 2001 18:27:11 -0500, 
Robert Love <rml@tech9.net> wrote:
>On Fri, 2001-12-07 at 18:20, Keith Owens wrote:
>
>> How long do people plan to keep drm 4.0 code in their versions of the
>> kernel?
>
>For 2.5, there probably is no intention of keeping that around.  But can
>we honestly ditch it in the middle of a stable kernel?  Personally I
>don't use it, but its not polite ...

Linus ditched drm 4.0 months ago.  It only survives in arch add on
patches like ia64 and in -ac trees.

