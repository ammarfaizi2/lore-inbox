Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbTLKO4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbTLKO4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:56:41 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:53435 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S265101AbTLKO4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:56:30 -0500
Date: Thu, 11 Dec 2003 07:58:47 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Ian Kumlien <pomac@vapor.com>
Cc: linux-kernel@vger.kernel.org, ross@datscreative.com.au,
       macro@ds2.pg.gda.pl
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031211145847.GA609@tesore.local>
References: <200312072312.01013.ross@datscreative.com.au> <200312101543.39597.ross@datscreative.com.au> <Pine.LNX.4.55.0312101653490.31543@jurand.ds.pg.gda.pl> <200312111655.25456.ross@datscreative.com.au> <1071143274.2272.4.camel@big.pomac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071143274.2272.4.camel@big.pomac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My mptable output looks pretty weird.  (Product ID "ny Key "?)
It doesn't even compare to the other two.  I have a shuttle AN35N.


===============================================================================

MPTable, version 2.0.15 Linux

-------------------------------------------------------------------------------

MP Floating Pointer Structure:

  location:			BIOS
  physical address:		0x000f5650
  signature:			'_MP_'
  length:			16 bytes
  version:			1.1
  checksum:			0x00
  mode:				Virtual Wire

-------------------------------------------------------------------------------

MP Config Table Header:

  physical address:		0x0xf0c00
  signature:			'N   '
  base table length:		8224
  version:			1.32
  checksum:			0x20
  OEM ID:			'    : '
  Product ID:			'ny Key '
  OEM table pointer:		0x2031462d
  OEM table size:		17152
  entry count:			29300
  local APIC address:		0x32462d6c
  extended table length:	32
  extended table checksum:	67

-------------------------------------------------------------------------------

MP Config Base Table Entries:

--
MPTABLE HOSED! record type = 114
