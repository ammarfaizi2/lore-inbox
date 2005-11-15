Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVKOX2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVKOX2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVKOX2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:28:35 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:3247 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932570AbVKOX2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:28:34 -0500
Date: Tue, 15 Nov 2005 15:28:28 -0800
From: Paul Jackson <pj@sgi.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
       haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051115152828.7451993b.pj@sgi.com>
In-Reply-To: <437A6BF5.9040901@fr.ibm.com>
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115010155.GA3792@IBM-BWN8ZTBWAO1>
	<20051114175140.06c5493a.pj@sgi.com>
	<20051115022931.GB6343@sergelap.austin.ibm.com>
	<20051114193715.1dd80786.pj@sgi.com>
	<20051115051501.GA3252@IBM-BWN8ZTBWAO1>
	<20051114223513.3145db39.pj@sgi.com>
	<20051115081100.GA2488@IBM-BWN8ZTBWAO1>
	<20051115010624.2ca9237d.pj@sgi.com>
	<20051115190030.GA16790@sergelap.austin.ibm.com>
	<20051115141146.5add977c.pj@sgi.com>
	<437A6BF5.9040901@fr.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric wrote:
> Indeed. Did you ever think about using PAGG as a foundation for a
> checkpoint/restart container ?

Other than the name, I didn't realize that PAGG provided a
good foundation for this work.  However, I should let my
PAGG colleagues address that further if worthwhile.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
