Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263368AbTIBAGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 20:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbTIBAGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 20:06:16 -0400
Received: from terminus.zytor.com ([63.209.29.3]:7309 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S263368AbTIBAGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 20:06:14 -0400
Message-ID: <3F53DEE1.5000709@zytor.com>
Date: Mon, 01 Sep 2003 17:05:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Wes Janzen <superchkn@sbcglobal.net>,
       Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: -mm patches on www.kernel.org ?
References: <Pine.LNX.4.51.0308071636100.31463@dns.toxicfilms.tv> <20030901211108.GE31760@matchmail.com> <3F53B937.10103@sbcglobal.net> <20030901225339.GH31760@matchmail.com>
In-Reply-To: <20030901225339.GH31760@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Mon, Sep 01, 2003 at 04:25:11PM -0500, Wes Janzen wrote:
> 
>>I think he's saying, why not put a link to the mm kernels from the 
>>www.kernel.org homepage, just like the ac kernels...  At least that's 
>>how I read it.
> 
> Ok, then I can agree with that.

Can't do it.  The -mm kernels aren't a single patch, they're patch sets, 
and they won't work with the system that we have set up.  If akpm wants 
to make a unified patch for each patch set in addition to the set itself 
then it can be done.

	-hpa

