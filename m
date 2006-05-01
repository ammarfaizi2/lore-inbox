Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWEAPB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWEAPB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 11:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWEAPB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 11:01:58 -0400
Received: from nevyn.them.org ([66.93.172.17]:7128 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932130AbWEAPB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 11:01:57 -0400
Date: Mon, 1 May 2006 11:01:54 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060501150154.GA3405@nevyn.them.org>
Mail-Followup-To: Jeff Dike <jdike@addtoit.com>,
	Blaisorblade <blaisorblade@yahoo.it>,
	user-mode-linux-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604261747.54660.blaisorblade@yahoo.it> <20060426154607.GA8628@ccure.user-mode-linux.org> <200604282228.46681.blaisorblade@yahoo.it> <20060429014956.GB9734@ccure.user-mode-linux.org> <20060501135127.GA1276@nevyn.them.org> <20060501134552.GA3686@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501134552.GA3686@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 09:45:52AM -0400, Jeff Dike wrote:
> The example above is a sketch, not a fully formed, compilable user.  Every
> proposed interface has had the mask length passed in - in the case
> above in the data argument.

Oh.  Well, then, I must have missed a message when I read the thread
this morning - sorry.  I'll watch for the next posting.

-- 
Daniel Jacobowitz
CodeSourcery
