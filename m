Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTDDIg7 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 03:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTDDIg6 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 03:36:58 -0500
Received: from siaab2ab.compuserve.com ([149.174.40.130]:12642 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263357AbTDDIgy (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 03:36:54 -0500
Date: Fri, 4 Apr 2003 03:44:23 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH][2.5] smp_call_function needs mb() - oopsable
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304040348_MC3-1-32F1-F0D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  <0>Kernel panic: Aiee, killing interrupt handler!


 Where is that extra space before the '<0>' coming from???

--
Chuck
