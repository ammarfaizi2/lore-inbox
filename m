Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbTIWQC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbTIWQC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:02:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:2915 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261617AbTIWQCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:02:25 -0400
Date: Tue, 23 Sep 2003 17:02:16 +0100
From: Dave Jones <davej@redhat.com>
To: Orion Poplawski <orion@cora.nwra.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops on redhat 9 kernel 2.4.20-20.9
Message-ID: <20030923160216.GA22053@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Orion Poplawski <orion@cora.nwra.com>, linux-kernel@vger.kernel.org
References: <bkppgj$2oc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bkppgj$2oc$1@sea.gmane.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 09:40:02AM -0600, Orion Poplawski wrote:
 > System is basically stock & updated redhat 9.  Kernel is tainted by the 
 > nvidia driver, but I hope that is not counted too heavily against me.

Very heavily. If you can reproduce it without having loaded that driver
at all, then file a bug at http://bugzilla.redhat.com

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
