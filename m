Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTGATmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTGATmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:42:11 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:20922 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S262945AbTGATmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:42:09 -0400
Subject: RE: How to Avoid GPL Issue
From: Steven Cole <elenstev@mesatop.com>
To: "Heater, Daniel (IndSys, " "GEFanuc, VMIC)" 
	<Daniel.Heater@gefanuc.com>
Cc: "'G. C.'" <gpc01532@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <A9D3E503844A904CB9E42AD008C1C7FDBA9BD6@vacho3misge.cho.ge.com>
References: <A9D3E503844A904CB9E42AD008C1C7FDBA9BD6@vacho3misge.cho.ge.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057089350.13992.37.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Jul 2003 13:55:51 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 13:36, Heater, Daniel (IndSys, GEFanuc, VMIC)
wrote:
> > We are trying to port a third party hardware driver into Linux kernel and 
> > this third party vendor does not allow us to publish the source code. Is 
> > there any approach that we can avoid publicizing the third party code
> while 
> > porting to Linux? Do we need to write some shim layer code in Linux kernel
> 
> > to interface the third party code? How can we do that? Is there any
> document 
> > or samples?
> 
> It depends on what you intend to do with your port. If it is only for
> internal use (you will not distribute the ported code in any form)
> then you may not be required to supply the source code to anyone. This is
> a common interpretation of the GPL (although I can not find explicit
> language providing for this interpretation in the license).

Look here:
http://www.gnu.org/licenses/gpl-faq.html#GPLRequireSourcePostedPublic

Steven


