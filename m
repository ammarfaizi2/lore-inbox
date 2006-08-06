Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWHFHBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWHFHBu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 03:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWHFHBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 03:01:49 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:42935 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751535AbWHFHBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 03:01:49 -0400
Date: Sun, 6 Aug 2006 02:57:06 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: IO errors after some uptime on 2.6.17.7
To: Joseph Pingenot <trelane@digitasaru.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608060300_MC3-1-C736-6A0E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060806041700.GA5157@digitasaru.net>

On Sat, 5 Aug 2006 23:17:01 -0500, Joseph Pingenot wrote:

> I've now seen two boxes with 2.6.17.7 go down with IO errors after some
>   time running.  There doesn't seem to necessarily be a fixed amount of
>   time, nor can I precisely figure out what's causing it.

How do you know they were IO errors?

Did previous versions of 2.6.17 work?

Please try to get debug output with netconsole if you can.

-- 
Chuck

