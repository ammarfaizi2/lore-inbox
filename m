Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVILRLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVILRLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVILRLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:11:37 -0400
Received: from terminus.zytor.com ([209.128.68.124]:17334 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751063AbVILRLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:11:35 -0400
Message-ID: <4325B698.1050805@zytor.com>
Date: Mon, 12 Sep 2005 10:10:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Junio C Hamano <junkio@cox.net>
CC: Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
References: <m3mzmjvbh7.fsf@telia.com>	<Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>	<20050911185711.GA22556@mars.ravnborg.org>	<Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>	<20050911194630.GB22951@mars.ravnborg.org>	<Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>	<52irx7cnw5.fsf@cisco.com>	<Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>	<Pine.LNX.4.58.0509111431400.3242@g5.osdl.org> <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
> 
> For kernel.org, you could say '/pub/scm/blah' in your alternates
> and expect it to work, only because http://kernel.org/pub
> hierarchy happens to match the absolute path /pub on the
> filesystem...
 >

Actually it doesn't.  /pub in the root directory on kernel.org is just a 
convenience symlink.

	-hpa
