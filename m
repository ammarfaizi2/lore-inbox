Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVCWPbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVCWPbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVCWPaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:30:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:26071 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262686AbVCWP3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:29:19 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16961.35656.576684.890542@tut.ibm.com>
Date: Wed, 23 Mar 2005 09:29:12 -0600
To: kingsley@aurema.com
Cc: Tom Zanussi <zanussi@us.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: read() on relayfs channel returns premature 0
In-Reply-To: <20050323090254.GA10630@aurema.com>
References: <20050323090254.GA10630@aurema.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kingsley@aurema.com writes:
 > 
 > Now I understand that this is not the latest release of relayfs (there
 > are the redux patches, which I have yet to try).  Nonetheless I'd like
 > to know whether this behaviour is deliberate.  Is it? 

Nope, looks like you've found a bug - thanks for the patch.  Any
chance you can send me your module so I can easily reproduce the
problem and test the fix?

Thanks,

Tom


