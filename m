Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWA1EkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWA1EkB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 23:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWA1EkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 23:40:01 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40377 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751401AbWA1EkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 23:40:00 -0500
Date: Fri, 27 Jan 2006 20:39:49 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bart@samwel.tk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix overflow issues with sysctl values in
 centiseconds/seconds
Message-Id: <20060127203949.1a87be2c.pj@sgi.com>
In-Reply-To: <20060127195539.6ffc3d3a.akpm@osdl.org>
References: <43DADB03.7080606@samwel.tk>
	<20060127195539.6ffc3d3a.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A third alternative for sending patches, a patch-bomb script,
such as one I maintain:

  http://www.speakeasy.org/~pj99/sgi/sendpatchset

Read the usage in the script for its documentation.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
