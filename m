Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVIMQ0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVIMQ0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVIMQ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:26:12 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:30218 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S964853AbVIMQ0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:26:11 -0400
Message-ID: <4326FDA2.90808@rulez.cz>
Date: Tue, 13 Sep 2005 18:26:10 +0200
From: iSteve <isteve@rulez.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: query_modules syscall gone? Any replacement?
References: <4KSFY-2pO-17@gated-at.bofh.it> <E1EDpQq-0000iV-Oe@be1.lrz> <4326DE0E.2060306@rulez.cz> <Pine.LNX.4.50.0509130813010.7614-100000@shark.he.net> <4326F093.80206@rulez.cz> <Pine.LNX.4.50.0509130835120.7614-100000@shark.he.net>
In-Reply-To: <Pine.LNX.4.50.0509130835120.7614-100000@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I would like to be able to query symbols of a loaded module, get list of
>>and list of dependencies of loaded module from an app, preferably
>>without having to parse a file...
> 
> 
> No, no syscall to do that.  Looks like it will require reading
> and parsing files.
> 
> And you answered my "what" question clearly, so I have one more.
> Why?  for what purpose, to what end?  What are you tring to
> accomplish?

The files so far provided still do not seem to give these informations 
though...

Part of the project I'm working on -- click-click ui for handling 
modules, with some perks: in this case, getting info about loaded 
modules that I hoped to obtain via query_module.

Oh, and one more question: There were no particular issues with 
query_module, or were they? If there weren't, why wasn't it kept?
