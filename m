Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269142AbUHYCJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269142AbUHYCJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 22:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269143AbUHYCJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 22:09:29 -0400
Received: from mfep3.odn.ne.jp ([143.90.131.181]:30122 "EHLO t-mta3.odn.ne.jp")
	by vger.kernel.org with ESMTP id S269142AbUHYCJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 22:09:19 -0400
Date: Wed, 25 Aug 2004 11:09:16 +0900
From: Aric Cyr <acyr@alumni.uwaterloo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI + Floppy detection problem in 2.6.8.1-mm4
Message-ID: <20040825020916.GA14422@alumni.uwaterloo.ca>
References: <20040825014028.GA14286@alumni.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825014028.GA14286@alumni.uwaterloo.ca>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 10:40:28AM +0900, acyr@alumni.uwaterloo.ca wrote:
> done.  I just noticed the no_acpi floppy module param in the source,
> so I will give that a try.  Since the ACPI code seems to be picking up

I just tried the no_acpi module param and the floppy driver loads and
works just fine, so this is indeed an ACPI related.

-- 
Aric Cyr <acyr at alumni dot uwaterloo dot ca>    (http://acyr.net)
gpg fingerprint: 943A 1549 47AC D766 B7F8  D551 6703 7142 C282 D542
