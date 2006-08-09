Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWHIBEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWHIBEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWHIBEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:04:00 -0400
Received: from mail.suse.de ([195.135.220.2]:52642 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030386AbWHIBDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:03:36 -0400
From: Andi Kleen <ak@suse.de>
To: "Keith Mannthey" <kmannth@gmail.com>
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
Date: Wed, 9 Aug 2006 03:03:14 +0200
User-Agent: KMail/1.9.3
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Hugh Dickins" <hugh@veritas.com>, "Andrew Morton" <akpm@osdl.org>,
       "Rusty Russell" <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com> <m13bc8b6ca.fsf@ebiederm.dsl.xmission.com> <a762e240608081710h532f6bbl7a1670537fd481bd@mail.gmail.com>
In-Reply-To: <a762e240608081710h532f6bbl7a1670537fd481bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090303.14635.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Again thing work as expected with 2.6.18-rc3.

Everything I knew of is fixed in the latest version of the patch, just -mm* still
has the old one.

It's useless to report any more bugs against the -mm* version.
 
-Andi

