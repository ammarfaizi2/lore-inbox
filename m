Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWCBDpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWCBDpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWCBDpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:45:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14777 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932451AbWCBDpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:45:22 -0500
Date: Wed, 1 Mar 2006 22:45:01 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060302034501.GA29423@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Ashok Raj <ashok.raj@intel.com>
References: <20060301224647.GD1440@redhat.com> <200603020238.31639.ak@suse.de> <20060302031348.GE19755@redhat.com> <200603020424.42500.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603020424.42500.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 04:24:41AM +0100, Andi Kleen wrote:

 > > Why ACPI decides to create 3 processor entries is still odd though.
 > 
 > It should be four.

Then I guess the ACPI guys have an off-by-one bug somewhere ;)

		Dave
