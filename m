Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbUAGNkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUAGNkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:40:43 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:59807 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S266101AbUAGNki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:40:38 -0500
To: linux-kernel@vger.kernel.org, dhollis@davehollis.com
Subject: Slow receive with AX8817 USB2 ethernet adapter
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 07 Jan 2004 14:40:35 +0100
Message-ID: <yw1xr7ybvpv0.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm getting very bad receive rates with a Netgear FA-120 USB2 Ethernet
adapter under Linux 2.6.0.  Timing an incoming TCP stream, I get only
600 kB/s.  Sending works properly at 10 MB/s.  I first reported this
problem some time in July or August.  Is it just me having this issue?
Can I get any helpful information somehow?

-- 
Måns Rullgård
mru@kth.se
