Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUGJR5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUGJR5W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 13:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUGJR5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 13:57:22 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:33258 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266316AbUGJR5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 13:57:21 -0400
Message-ID: <40F02E05.8090401@namesys.com>
Date: Sat, 10 Jul 2004 10:57:25 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Dave Jones <davej@redhat.com>, jmerkey@comcast.net,
       Pete Harlan <harlan@artselect.com>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
References: <070920041920.2370.40EEEFFD000B341B000009422200763704970A059D0A0306@comcast.net> <40EF797E.6060601@namesys.com> <20040710083347.GC6386@redhat.com> <40F02963.5040500@namesys.com> <20040710174432.GA18719@infradead.org>
In-Reply-To: <20040710174432.GA18719@infradead.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Sat, Jul 10, 2004 at 10:37:39AM -0700, Hans Reiser wrote:
>  
>
>>Fedora is something new.  It is good that fedora tracks the mainline.  
>>Kudos for that.  You should do that with RHEL.
>>    
>>
>
>Does someone volunteer to sponsor Hans a free "Release Managment 101" course?
>
>
>  
>
RHEL applies all sorts of patches that have not been tested in mainline, 
and then tells its customers that it is more stable when the reverse is 
true.  RHEL should pick a stable mainline kernel 6 weeks after it has 
proven stable, and use it.
Their not applying reiserfs bugfixes that are present in the mainline is 
just more evidence that they don't care about stability as much as 
marketing.

Lindows does it right.

Hans
