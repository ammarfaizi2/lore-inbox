Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVDFAul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVDFAul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 20:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVDFAul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 20:50:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22211 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262008AbVDFAug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 20:50:36 -0400
Date: Tue, 5 Apr 2005 20:48:07 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: Ryan Anderson <ryan@michonline.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, stable@kernel.org, amy.griffis@hp.com,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, dwmw2@infradead.org
Subject: Re: [03/08] fix ia64 syscall auditing
Message-ID: <20050406004807.GB13518@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	Ryan Anderson <ryan@michonline.com>, davidm@hpl.hp.com,
	linux-kernel@vger.kernel.org, stable@kernel.org, amy.griffis@hp.com,
	tony.luck@intel.com, linux-ia64@vger.kernel.org,
	dwmw2@infradead.org
References: <20050405164539.GA17299@kroah.com> <20050405164647.GD17299@kroah.com> <16978.62622.80542.462568@napali.hpl.hp.com> <1112734158.468.0.camel@localhost.localdomain> <20050405234602.GC4800@mythryan2.michonline.com> <1112745904.412.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112745904.412.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 05:05:04PM -0700, Greg KH wrote:
 > On Tue, 2005-04-05 at 19:46 -0400, Ryan Anderson wrote:
 > > highlight WhitespaceEOL ctermbg=red guibg=red
 > > match WhitespaceEOL /\s\+$/
 > 
 > Very nice, thanks a lot for that.
 
let c_space_errors=1  also works great.

		Dave

