Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWINWsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWINWsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWINWsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:48:37 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50654 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932092AbWINWsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:48:36 -0400
Subject: Re: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in
	get_memcfg_from_srat
From: Dave Hansen <haveblue@us.ibm.com>
To: kmannth@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Vivek goyal <vgoyal@in.ibm.com>,
       ebiederm@xmission.com, andrew <akpm@osdl.org>
In-Reply-To: <1158273830.15745.14.camel@keithlap>
References: <1158113895.9562.13.camel@keithlap>
	 <1158269696.15745.5.camel@keithlap>
	 <1158271274.24414.6.camel@localhost.localdomain>
	 <1158273830.15745.14.camel@keithlap>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 15:48:27 -0700
Message-Id: <1158274107.24414.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do the ptes look?

-- Dave

