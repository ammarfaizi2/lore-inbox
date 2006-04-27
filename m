Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWD0Fxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWD0Fxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 01:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWD0Fxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 01:53:38 -0400
Received: from main.gmane.org ([80.91.229.2]:21134 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964943AbWD0Fxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 01:53:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Roman Kononov <kononov195-far@yahoo.com>
Subject: Re: C++ pushback
Date: Thu, 27 Apr 2006 00:53:22 -0500
Message-ID: <44505C52.2080709@yahoo.com>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <e2ou35$u5r$1@sea.gmane.org> <20060427035709.GF13027@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-69-219-188-74.dsl.chcgil.ameritech.net
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20060427035709.GF13027@w.ods.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2006 22:57, Willy Tarreau wrote:
> On Wed, Apr 26, 2006 at 06:00:52PM -0500, Roman Kononov wrote:
>> Linus Torvalds wrote:
>>> - the compilers are slower, and less reliable. This is _less_ of an 
>>> issue these days than it used to be (at least the reliability part), 
>>>   but it's still true.
>> G++ compiling heavy C++ is a bit slower than gcc. The g++ front end is 
>> reliable enough. Do you have a particular bug in mind?
> 
> Obviously you're not interested in gcc evolutions. I suggest that you
> take your browser to http://gcc.gnu.org/gcc-3.4/changes.html#3.4.5
> This is the last version which showed per-subsystem problem reports
> before they used SVN. Just count the lines : 9 bugs fixed for C, 45
> for C++. And when you read those bugs, you don't have the feeling of
> reading a description of something that people make their code rely on.

I am interested very much. And if one really understands the bugs 
listed, he can say that they are minor for both C and C++. I would 
certainly recommend rely on g++.

Regards,
Roman

