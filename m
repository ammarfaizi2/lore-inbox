Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbTELPAZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTELPAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:00:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14825 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262163AbTELPAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:00:24 -0400
Message-ID: <3EBFB988.5090907@us.ibm.com>
Date: Mon, 12 May 2003 08:11:04 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.69-mjb1
References: <9380000.1052624649@[10.10.2.4]> <20030512132939.GF19053@holomorphy.com> <21850000.1052743254@[10.10.2.4]> <20030512150309.GG19053@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, May 12, 2003 at 05:40:55AM -0700, Martin J. Bligh wrote:
> 
>>Can I get some sort of vague explanation please? ;-)
> 
> How obvious does it have to be?

More obvious than that :)

> Those are trying to fish out the 2nd and 5th words from the top of the
> stack. Magic numbers stopped working; symbolic constants save the day.

I guess I'm not understanding _why_ they're guaranteed to be there.

-- 
Dave Hansen
haveblue@us.ibm.com

