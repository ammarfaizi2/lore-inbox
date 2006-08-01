Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWHAJdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWHAJdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWHAJdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:33:50 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:45493 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S932552AbWHAJdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:33:49 -0400
Message-ID: <44CEBD77.2060502@namesys.com>
Date: Mon, 31 Jul 2006 20:33:27 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <20060731165406.GA8526@merlin.emma.line.org>
In-Reply-To: <20060731165406.GA8526@merlin.emma.line.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>
>>Have you ever seen VxFS or WAFL in action?
>>    
>>
>
>No I haven't. As long as they are commercial, it's not likely that I
>will.
>  
>
WAFL was well done.   It has several innovations that I admire,
including quota trees, non-support of fragments for performance reasons,
and the basic WAFL notion applied to an NFS RAID special (though
important) case.
