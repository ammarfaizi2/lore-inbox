Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264218AbRFDMkp>; Mon, 4 Jun 2001 08:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264220AbRFDMUu>; Mon, 4 Jun 2001 08:20:50 -0400
Received: from docs3.abcrs.com ([63.238.77.222]:61701 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S264219AbRFDMUg>; Mon, 4 Jun 2001 08:20:36 -0400
Date: Mon, 4 Jun 2001 08:20:01 -0400
Message-Id: <200106041220.IAA07493@mailer.progressive-comp.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] security rules?  (and 2.4.5-ac4 security bug)
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-06-03, Dawson Engler <engler@csl.Stanford.EDU> wrote:

> Additionally, do people have suggestions for good security rules?
> We're looking to expand our security checkers.  Right now we just have
> checkers that warn when:

Do you already have checks for signed/unsigned issues?  Those often result
in security problems, although you may already be checking for them simply
for reliable-code purposes.  ...Hm, looking at the archives, I see Chris
Evans responded about signedness issues when you asked last month :-P

You may want to check out and/or subscribe to the security-audit list; most
of the discussion is about userland security issues but kernel problems (or
potential  ones) are discussed as well.  We have archives of the list at:
http://marc.theaimsgroup.com/?l=linux-security-audit&r=1&w=2
And see http://www.linuxhelp.org/lsap.shtml for more info, subscribing,
etc.

--
Hank Leininger <hlein@progressive-comp.com> 
  
