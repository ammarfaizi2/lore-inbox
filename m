Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVDFQDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVDFQDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 12:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVDFQDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 12:03:25 -0400
Received: from palrel13.hp.com ([156.153.255.238]:47800 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262243AbVDFQCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 12:02:46 -0400
Date: Wed, 6 Apr 2005 09:03:24 -0700
From: Grant Grundler <iod00d@hp.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: davidm@hpl.hp.com, Christoph Lameter <clameter@engr.sgi.com>,
       Andi Kleen <ak@muc.de>, Christoph Lameter <clameter@sgi.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher order
Message-ID: <20050406160324.GC29122@esmail.cup.hp.com>
References: <16979.27158.381388.691910@napali.hpl.hp.com> <E1DJ2sp-0004jm-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DJ2sp-0004jm-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 10:15:18PM -0700, Gerrit Huizenga wrote:
> SpecSDET, Aim7 or ReAim from OSDL are probably what you are thinking of.

SDET isn't publicly available.
I hope by now osdl-reaim is called "osdl-aim7":
	http://lkml.org/lkml/2003/8/1/172

grant
