Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWDMSVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWDMSVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWDMSVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:21:54 -0400
Received: from smtp-out-02.utu.fi ([130.232.202.172]:37549 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S964777AbWDMSVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:21:53 -0400
Date: Thu, 13 Apr 2006 21:21:42 +0300
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: JVM performance on Linux (vs. Solaris/Windows)
In-reply-to: <443E74C1.5090801@mbligh.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: K P <kplkml@gmail.com>, linux-kernel@vger.kernel.org
Message-id: <200604132121.42662.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com>
 <443E74C1.5090801@mbligh.org>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 18:56, Martin J. Bligh wrote:

> SpecJBB is a really frigging stupid benchmark. It's *much* more affected
> by the stupid crap in Java (like their locking model) than anything in the
> OS. 

What's even worse is that people actually code by this stupid model...
 
