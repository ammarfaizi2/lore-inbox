Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbTF2U3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbTF2U3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:29:12 -0400
Received: from oak.sktc.net ([64.71.97.14]:53475 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S264027AbTF2U1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:27:23 -0400
Message-ID: <3EFF4F00.9040608@sktc.net>
Date: Sun, 29 Jun 2003 15:41:36 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rmoser <mlmoser@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEEC3.30505@sktc.net> <200306291431080580.01CF24BF@smtp.comcast.net> <3EFF4443.8080507@sktc.net> <200306291605400290.0225B33F@smtp.comcast.net>
In-Reply-To: <200306291605400290.0225B33F@smtp.comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmoser wrote:

> Except for a crash at the precise moment that data is being written during
> a resize of a partition in LVM or the filesystem iteself.  To my knowledge,
> said operation is not journaled.

And the window of vulnerability for my method is very small - for yours 
it is very large (the whole duration of the conversion operation.)

Sorry, but I've seen too many folks like you in the past on lists like 
this. You write in with a poorly considered idea, and when people try to 
show you why it won't work you plug your ears and say 
"Nyah-Nyah-Nyah-I'm-not-listening".

As I said before: if you think this is so easy to do, DO IT. SHOW US THE 
CODE.

Until you do, I consider this "discussion" at an end.

