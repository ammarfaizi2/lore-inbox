Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267210AbTGOLoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267256AbTGOLoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:44:39 -0400
Received: from fmr06.intel.com ([134.134.136.7]:49867 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267210AbTGOLoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:44:38 -0400
Message-ID: <3F13EC3F.9040209@intel.com>
Date: Tue, 15 Jul 2003 14:57:51 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: PATCH: seq_file interface to provide large data chunks
References: <3F0D217B.4040900@intel.com> <1057835373.8028.0.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1057835373.8028.0.camel@dhcp22.swansea.linux.org.uk>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of weeks ago I submitted (for 2.4 series) the patch for seq_file 
that fixes read() behavior to be able return more than one page of data. 
There was quick mail exchange with Alan, he pointed out that there is 
some more seq_file stuff (for "single", by the way). Since that - no any 
information, whether this seq_file stuff is going to be included or, if 
not, at least any reason. 2.4.22-pre6 released with no seq_file changes.

Regarding to this, I have more generic question: is it some way to track 
status of patches? Accepted/rejected, scheduled for xxx version? For 2.5 
kernel, Bugzilla provides this feature. What for 2.4?

Vladimir.


