Return-Path: <linux-kernel-owner+w=401wt.eu-S1422696AbXAETfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbXAETfF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbXAETfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:35:05 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:41223 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422696AbXAETfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:35:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: 2.6.20-rc3-git4 oops on suspend: __drain_pages
Date: Fri, 5 Jan 2007 20:36:09 +0100
User-Agent: KMail/1.9.1
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <459DB116.9070805@shaw.ca> <Pine.LNX.4.64.0701051114200.28395@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701051114200.28395@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701052036.10647.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 5 January 2007 20:15, Christoph Lameter wrote:
> On Thu, 4 Jan 2007, Robert Hancock wrote:
> 
> > Saw this oops on 2.6.20-rc3-git4 when attempting to suspend. This only
> > happened in 1 of 3 attempts.
> 
> See the fix that I posted yesterday to linux-mm. Its now in Andrew's tree.

I can't find it in -mm.

Could you please post it here?

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
