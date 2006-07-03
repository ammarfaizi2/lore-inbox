Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWGCWWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWGCWWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWGCWWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:22:04 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:18157 "EHLO
	ns1.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932155AbWGCWWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:22:01 -0400
Message-ID: <44A9A1B0.9090702@wolfmountaingroup.com>
Date: Mon, 03 Jul 2006 17:01:04 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: arjan@infradead.org, zdzichu@irc.pl, helgehaf@aitel.hist.no,
       sithglan@stud.uni-erlangen.de, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	<20060701170729.GB8763@irc.pl>	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>	<20060701181702.GC8763@irc.pl>	<20060703202219.GA9707@aitel.hist.no>	<20060703205523.GA17122@irc.pl>	<1151960503.3108.55.camel@laptopd505.fenrus.org>	<44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com>
In-Reply-To: <20060703232547.2d54ab9b.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:

>El Mon, 03 Jul 2006 15:46:55 -0600,
>"Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> escribió:
>
>  
>
>>Add a salvagable file system to ext4, i.e. when a file is deleted, you 
>>just rename it and move it to a directory called DELETED.SAV and recycle 
>>the files as people allocate new ones.  Easy to do (internal "mv" of 
>>    
>>
>
>
>Easily doable in userspace, why bother with kernel programming
>
>  
>
Fine, leave it out.  More for me that way in additive features for my 
products for stuff Linux does not provide.

Jeff
