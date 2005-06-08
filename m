Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVFHACK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVFHACK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 20:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVFHACK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 20:02:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17373 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262044AbVFHACI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 20:02:08 -0400
Date: Tue, 7 Jun 2005 17:02:03 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
In-Reply-To: <20050607165656.2517b417.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0506071659580.30849@schroedinger.engr.sgi.com>
References: <1004450000.1118188239@flay> <20050607165656.2517b417.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2005, Andrew Morton wrote:

> > Diffprofile is wacko (HZ seems to be defaulting to 250 in -mm).
> 
> Oh crap, so it does.  That's wrong.

Email by you and Linus indicated that 250 should be the default.
