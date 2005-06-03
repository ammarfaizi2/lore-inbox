Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVFCNMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFCNMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 09:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVFCNMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 09:12:51 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:1727 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261249AbVFCNMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 09:12:50 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] automated linux kernel testing results
Date: Fri, 3 Jun 2005 16:12:30 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Adam Litke <agl@us.ibm.com>, Enrique Gaona <egaona@us.ibm.com>
References: <531740000.1117749798@flay>
In-Reply-To: <531740000.1117749798@flay>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506031612.30638.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 June 2005 01:03, Martin J. Bligh wrote:
> OK, I've finally got this to the point where I can publish it.
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
>
> Currently it builds and boots any mainline, -mjb, -mm kernel within
> about 15 minutes of release. runs dbench, tbench, kernbench, reaim and fsx.
> Currently I'm using a 4x AMD64 box, a 16x NUMA-Q, 4x NUMA-Q, 32x x440 (ia32)
> PPC64 Power 5 LPAR, PPC64 Power 4 LPAR, and PPC64 Power 4 bare metal system.
> The config files it uses are linked by the machine names in the column 
> headers.

Wow. 8]

Some (but not all) green links like [GOOD 4550] lead to 404 land. Is this intended?
--
vda

