Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263321AbVCKAdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263321AbVCKAdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbVCKAdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:33:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51685 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263414AbVCJWpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:45:25 -0500
Date: Thu, 10 Mar 2005 17:45:22 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
In-Reply-To: <423082BF.6060007@comcast.net>
Message-ID: <Pine.LNX.4.61.0503101744170.16741@chimarrao.boston.redhat.com>
References: <423075B7.5080004@comcast.net> <423082BF.6060007@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005, John Richard Moser wrote:

> A Linux specific binary driver format might be more useful,

No, it wouldn't.  I can use a source code driver on x86,
x86-64 and PPC64 systems, but a binary driver is only
usable on the architecture it was compiled for.

Source code is way more portable than binary anything.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
