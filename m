Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbVHEMAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVHEMAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 08:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVHEMAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 08:00:44 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:46049 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262996AbVHEMAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 08:00:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=oYYpQp3WkW5jdUlQa8MnilwJMwy2Xn8T+HI3GdWR+/NWBaOfNUeVdbUsosmwuutxXwL7XcK11JgyWfozIyVKEe/DYzvjvC+7F6Sx8VwHRt7hdI3gXp7eUM97VVf4Cn//m+CswmtXgBUa1qHWK3twmc/2SuBPQFz3jF7gs+3SD50=
Message-ID: <42F354DF.2050402@googlemail.com>
Date: Fri, 05 Aug 2005 14:00:31 +0200
User-Agent: Thunderbird 1.0+ (Windows/20050801)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: robert.moore@intel.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: 2.6.13-rc3-mm3
References: <971FCB6690CD0E4898387DBF7552B90E023F8527@orsmsx403.amr.corp.intel.com>	<42EAC9DB.9010702@gmail.com> <20050804155513.727a3894.akpm@osdl.org>
In-Reply-To: <20050804155513.727a3894.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello Andrew,
> Andrew Morton wrote:
> Michael, I'm assuming that a) this problem remains in those -mm kernels
> which include git-acpi.patch and that b) the problems are not present in
> 2.6.13-rc5 or 2.6.13-rc6, yes?
>   
a.) I don't have any problems in 2.6.13-rc5-git[1-3] and 2.6.13-rc4-mm1 
they are working quite fantastic.
Good work :-)
> So I think we have a bug in git-acpi.patch?
>   
I reverted them and left them in..no problems with kernels I said above.
Again good work :-)
> If that's all correct then can you please test the next -mm (which will
> include git-acpi.patch - the most recent -mm did not) and if the bug's
> still there can you raise a bugzilla.kernel.org entry for it?
>   
I would, but the motherboard is dropped from my hardware test approval. 
Maybe I can get it back to test again
if it helps to solve some acpi issues.
> We seem to have a handful of bug reports against the -mm acpi patch.
>   
Well, I noticed that there are a lots of bugs and I'm willing to find 
search and reproduce them.

> Thanks.
I have to say thanks for the great help/feedback.

Greets and
Best regards

--
_Michael Thonke
IT-Systemintegrator /
System- and Softwareanalyist

