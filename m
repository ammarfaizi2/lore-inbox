Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTJ3HuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 02:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTJ3HuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 02:50:11 -0500
Received: from mail1.btignite.se ([194.213.69.35]:41745 "HELO
	mail1.btignite.se") by vger.kernel.org with SMTP id S262228AbTJ3HuI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 02:50:08 -0500
Message-ID: <3FA0BCDE.7080201@lanil.mine.nu>
Date: Thu, 30 Oct 2003 08:25:18 +0100
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com>
In-Reply-To: <3F9F7F66.9060008@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> They are building in support for transactions into the OS.
> 
> Everything will be in XML.  (It is not so important what format it is 
> in, as it is that they are going to do it in one format.)
> 
> Support for browsing versions in the FS.
> 
> Support for browsing and querying XML their unified format.  Ok, so SQL 
> sucks, but this is still better than what we offer today in Linux.

I think this is better implemented in userspace somehow to keep the 
kernel away from bloat.
What do you think of the GNOME Storage project: 
http://www.gnome.org/~seth/storage/

Its not exactly the same but maybe its going in that direction.

-- 
Christan Axelsson
smiler@lanil.mine.nu


