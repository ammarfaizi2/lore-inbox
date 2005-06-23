Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVFWLCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVFWLCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 07:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVFWLCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 07:02:11 -0400
Received: from mx1.suse.de ([195.135.220.2]:27877 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262140AbVFWLA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 07:00:29 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE LINUX Products GMBH
To: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Potential xdr_xcode_array2 security issue
Date: Thu, 23 Jun 2005 13:00:26 +0200
User-Agent: KMail/1.8
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olaf Kirch <okir@suse.de>
References: <200506230502.j5N52PWP007955@hera.kernel.org> <200506231153.41318.agruen@suse.de> <87hdfpz70t.fsf@deneb.enyo.de>
In-Reply-To: <87hdfpz70t.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506231300.27082.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 June 2005 12:45, Florian Weimer wrote:
> [...] I can't tell if you must protect against desc->elem_size beign zero.

No.

-- Andreas.
