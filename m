Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945893AbWJTMxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945893AbWJTMxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422800AbWJTMxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:53:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:63194 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030229AbWJTMxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:53:36 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH] [x86-64] Calgary: increase PHB1 split transaction timeout
Date: Fri, 20 Oct 2006 14:53:25 +0200
User-Agent: KMail/1.9.3
Cc: "Darrick J. Wong" <djwong@us.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jon Mason <jdmason@gmail.com>
References: <39faf4c673f99e4ee2ed.1161250303@rhun.haifa.ibm.com>
In-Reply-To: <39faf4c673f99e4ee2ed.1161250303@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610201453.25131.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 October 2006 11:35, Muli Ben-Yehuda wrote:
> This patch increases the timeout for PCI split transactions on PHB1 on
> the first Calgary to work around an issue with the aic94xx
> adapter. Fixes kernel.org bugzilla #7180
> (http://bugzilla.kernel.org/show_bug.cgi?id=7180)

Needed for .19 i guess?

-Andi
