Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTELVls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTELVls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:41:48 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:4578 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262765AbTELVlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:41:47 -0400
Date: Mon, 12 May 2003 17:51:25 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305121754_MC3-1-388D-BC60@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>   ...and on a related topic, if someone wrote a patch to optionally clear
>> the swap area at swapoff would it ever be accepted?
>
> man dd ?

  "That can be done manually" does not get you the check mark in
the list of features.  Management wants idiot-resistant security.
