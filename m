Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbVG3IpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVG3IpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 04:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVG3IpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 04:45:03 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:47816 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S263018AbVG3IoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 04:44:13 -0400
Date: Sat, 30 Jul 2005 04:39:04 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Making it easier to find which change introduced a bug
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200507300442_MC3-1-A5F6-A039@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Date: Thu, 28 Jul 2005 at 22:54:33 -0700, Andrew Morton wrote:

> We need a super-easy way for people to do bisection searching.

 First step would be to make interdiffs available as quilt patchsets.

 If we had this for e.g. 2.6.13-rc3 -> rc4 it would make tracking down
those new bugs much easier.

(Yes I know git does bisection but Andrew said it should be easy.)
__
Chuck
