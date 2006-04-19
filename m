Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWDSXjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWDSXjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWDSXjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:39:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:3477 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751330AbWDSXjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:39:09 -0400
From: Andi Kleen <ak@suse.de>
To: grundig <grundig@teleline.es>
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Date: Thu, 20 Apr 2006 01:38:00 +0200
User-Agent: KMail/1.9.1
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <p73mzeh2o38.fsf@bragg.suse.de> <20060420011037.6b2c5891.grundig@teleline.es>
In-Reply-To: <20060420011037.6b2c5891.grundig@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604200138.00857.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 April 2006 01:00, grundig wrote:

> From my user POV it seems
> really weird that a feature forbids you from using another unrelated feature

e.g. using a firewall usually prevents some applications
from working. Or using hugepages is not compatible with a lot of other VM
features. Or some locking doesn't work over NFS.

There are lots of things like this in the kernel like in any 
complex system.

-Andi
