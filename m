Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbTDFSrR (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 14:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTDFSrR (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 14:47:17 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:61844 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S263104AbTDFSrP (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 14:47:15 -0400
Date: Sun, 6 Apr 2003 11:58:49 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Stephan van Hienen <raid@a2000.nu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tuning disk on 3ware /performance problem
In-Reply-To: <Pine.LNX.4.53.0304061153050.2993@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.53.0304061158130.2883@twinlark.arctic.org>
References: <200304061131_MC3-1-333A-E630@compuserve.com>
 <Pine.LNX.4.53.0304061153050.2993@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003, dean gaudet wrote:

> time 'dd if=/dev/zero of=/fs/file1 bs=128k count=8k && sync'

ack... too early in the morning:

time sh -c 'dd if=/dev/zero of=/fs/file1 bs=128k count=8k && sync'

-dean
