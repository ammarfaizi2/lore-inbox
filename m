Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTDEKOL (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 05:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTDEKOL (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 05:14:11 -0500
Received: from siaab2ab.compuserve.com ([149.174.40.130]:40767 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262000AbTDEKOJ (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 05:14:09 -0500
Date: Sat, 5 Apr 2003 05:24:40 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Oops every write with ext3 + sync + data=journal
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304050525_MC3-1-331B-F7E4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter <sean@uncarved.com> wrote:


>rw,sync,data=journal,nosuid,nodev


Is there any good reason for using sync and data=journal together?

--
 Chuck
 I am not a number!
