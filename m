Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292858AbSCIRwl>; Sat, 9 Mar 2002 12:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292859AbSCIRwb>; Sat, 9 Mar 2002 12:52:31 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:710 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S292858AbSCIRw1>;
	Sat, 9 Mar 2002 12:52:27 -0500
Date: Sat, 09 Mar 2002 09:53:24 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: andersen@codepoet.org
cc: linux-kernel@vger.kernel.org
Subject: Re: 23 second kernel compile (aka which patches help scalibility on NUMA)
Message-ID: <126403558.1015667602@[10.10.2.3]>
In-Reply-To: <20020309164305.GA2914@codepoet.org>
In-Reply-To: <20020309164305.GA2914@codepoet.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, March 09, 2002 9:43 AM -0700 Erik Andersen <andersen@codepoet.org> wrote:
> On Fri Mar 08, 2002 at 09:47:04PM -0800, Martin J. Bligh wrote:
>> "time make -j32 bzImage" is now down to 23 seconds.
>> (16 way NUMA-Q, 700MHz P3's, 4Gb RAM).
> [-----------snip---------]
>> Any other suggestions are welcome. I'd also be interested
> 
> I suggest that you should give me your computer.  ;-) 

There's a very similar machine that's publicly available
in the OSDL (http://www.osdlab.org). I don't think they'll
let you take it home, but access is half way there ;-)

M.

