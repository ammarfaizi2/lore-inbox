Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754230AbWKHEvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbWKHEvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 23:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754233AbWKHEvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 23:51:24 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:46963 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1754226AbWKHEvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 23:51:23 -0500
X-IronPort-AV: i="4.09,399,1157353200"; 
   d="scan'208"; a="1862694352:sNHT74714394"
To: Andrew Morton <akpm@osdl.org>
Cc: Avi Kivity <avi@qumranet.com>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
X-Message-Flag: Warning: May contain useful information
References: <454E4941.7000108@qumranet.com>
	<20061107204440.090450ea.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 07 Nov 2006 20:51:20 -0800
In-Reply-To: <20061107204440.090450ea.akpm@osdl.org> (Andrew Morton's message of "Tue, 7 Nov 2006 20:44:40 -0800")
Message-ID: <adafycuh77b.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Nov 2006 04:51:20.0777 (UTC) FILETIME=[88BC6390:01C702F1]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > That's gas 2.16.1.  I assume it needs some super-new binutils.
 > 
 > I'm not sure what to do about this.  What's the minimum version?

According to http://kvm.sourceforge.net/howto.html :
    A recent enough binutils (>= 2.16.91.0.2) for vmx instruction support

 - R.
