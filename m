Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUHSL7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUHSL7q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUHSL7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:59:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30161 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265773AbUHSL7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:59:45 -0400
Date: Thu, 19 Aug 2004 17:29:12 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org, akpm@osdl.org,
       Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       litke@us.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH][4/6]Register snapshotting before kexec-boot
Message-ID: <20040819115912.GA3965@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040817120239.GA3916@in.ibm.com> <20040817120531.GB3916@in.ibm.com> <20040817120717.GC3916@in.ibm.com> <20040817120809.GD3916@in.ibm.com> <20040817120911.GE3916@in.ibm.com> <20040818134356.GA10970@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818134356.GA10970@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Wed, Aug 18, 2004 at 09:43:59AM -0400, Theodore Ts'o wrote:
> This patch is needed so that the kexec patches will compile on systems
> that don't have APIC's enabled.

Thanks a lot for the patch.

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore
