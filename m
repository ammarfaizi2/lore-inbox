Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUJDSWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUJDSWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUJDSWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:22:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:9384 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268149AbUJDSWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:22:09 -0400
Date: Mon, 04 Oct 2004 11:19:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: efocht@hpce.nec.com, akpm@osdl.org, nagar@watson.ibm.com,
       ckrm-tech@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <118630000.1096913944@flay>
In-Reply-To: <20041004090232.1180b3f8.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><200410032221.26683.efocht@hpce.nec.com><20041003134842.79270083.akpm@osdl.org><200410041605.30395.efocht@hpce.nec.com><842970000.1096901859@[10.10.2.4]><20041004083045.1432f511.pj@sgi.com><850440000.1096904504@[10.10.2.4]> <20041004090232.1180b3f8.pj@sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, October 04, 2004 09:02:32 -0700 Paul Jackson <pj@sgi.com> wrote:

> Martin, quoting Andrew:
>> >> appropriately modified CKRM, and a suitable controller.
>> 
>> So not CKRM as-is ...
> 
> Yes - by now we all agree that CKRM as it is doesn't provide some things
> that cpusets provides (though of course CKRM provides much more that
> cpusets doesn't.)
> 
> Andrew would ask, if I am channeling him correctly, how about CKRM as it
> could be?  What would it take to modify CKRM so that it could subsume
> (embrace and replace) cpusets, meeting all the requirements that in the
> end we agreed were essential for cpusets to meet, rendering cpusets
> redundant and no longer needed?

Well, or just merge the two somehow into one cohesive system, I'd think.
One doesn't need to completely subsume the other ;-)

M.

