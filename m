Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWHJFVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWHJFVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWHJFVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:21:05 -0400
Received: from ns.suse.de ([195.135.220.2]:29144 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161028AbWHJFVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:21:04 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
Date: Thu, 10 Aug 2006 07:20:56 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jan Beulich <jbeulich@novell.com>
References: <200608100101_MC3-1-C796-F8CA@compuserve.com>
In-Reply-To: <200608100101_MC3-1-C796-F8CA@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608100720.56548.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 06:59, Chuck Ebbert wrote:
> Part of the NMI handler is missing annotations.  Just moving
> the RING0_INT_FRAME macro fixes it.  And additional comments
> should warn anyone changing this to recheck the annotations.

Added thanks.
-Andi
