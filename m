Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWGXJNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWGXJNp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 05:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWGXJNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 05:13:45 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:32441 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751080AbWGXJNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 05:13:44 -0400
Message-ID: <44C4813E.2030907@namesys.com>
Date: Mon, 24 Jul 2006 02:13:50 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: lkml@lpbproductions.com, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com> <44C44622.9050504@namesys.com> <20060724085455.GD24299@merlin.emma.line.org>
In-Reply-To: <20060724085455.GD24299@merlin.emma.line.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

> The father declared his child unsupported, 
>
I never did that.

>and that's the end
>of the story for me. There's nothing wrong about focusing on newer code,
>but the old code needs to be cared for, too, to fix remaining issues
>such as the "can only have N files with the same hash value". 
>
Requires a disk format change, in a filesystem without plugins, to fix it.

>(I am well
>aware this is exploiting worst-case behavior in a malicious sense but I
>simply cannot risk such nonsense on a 270 GB RAID5 if users have shared
>work directories.)
>
>  
>
>

