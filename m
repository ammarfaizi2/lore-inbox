Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318061AbSHPCsS>; Thu, 15 Aug 2002 22:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSHPCsS>; Thu, 15 Aug 2002 22:48:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:63673 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318061AbSHPCsS>; Thu, 15 Aug 2002 22:48:18 -0400
Message-ID: <3D5C68DA.8020102@us.ibm.com>
Date: Thu, 15 Aug 2002 19:52:10 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 kmap_atomic copy_*_user benefits
References: <20020815232126.GR15685@holomorphy.com> <3D5C5F05.7080004@us.ibm.com> <20020816024436.GX15685@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
 > Hmm, I didn't catch this one. OTOH I did use a fwd port of an
 > earlier version of the patch. Shall we kgdb?

Yeah, that's the next step.

 > Which box/workload?

3b96 the 8-way Xeon 16GB, during the warmup of the specweb file set.
It also happened once at the end of a Specweb run

-- 
Dave Hansen
haveblue@us.ibm.com

