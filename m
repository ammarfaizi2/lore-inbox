Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbULZNa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbULZNa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 08:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbULZNa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 08:30:26 -0500
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:28166 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261650AbULZNaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 08:30:18 -0500
Message-ID: <41CEBCE4.9030602@benton987.fsnet.co.uk>
Date: Sun, 26 Dec 2004 13:30:12 +0000
From: Andrew Benton <andy@benton987.fsnet.co.uk>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20041223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: ide-cd hang while playing a CD in 2.6.10
References: <20041225234342.GA5177@widomaker.com>
In-Reply-To: <20041225234342.GA5177@widomaker.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Shannon Hendrix wrote:
> 
> I have a repeatable problem playing music CDs with kernel 2.6.8.1 and
> 2.6.10.
> 
> Running "gnome-cd" to play a CD, the drive and IDE bus flash a few times
> for about 15 seconds, and then the IDE bus light goes solid.
Does it work if you use a different application? Gnome-cd has never 
worked for me but Totem (with an xine backend) is playing CD's fine with 
a 2.6.10 kernel for me.
