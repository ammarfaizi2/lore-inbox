Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265260AbUFWOoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbUFWOoZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUFWOoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:44:24 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:19722 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265260AbUFWOm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:42:57 -0400
Date: Wed, 23 Jun 2004 09:42:17 -0500 (CDT)
From: Pat Gefre <pfg@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org, erikj@sgi.com, devies@lanana.org
Subject: Re: [PATCH 2.6] Altix serial driver
In-Reply-To: <20040622183621.GA7490@infradead.org>
Message-ID: <Pine.SGI.3.96.1040623094018.19458B-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, Christoph Hellwig wrote:

+ On Tue, Jun 22, 2004 at 11:24:42AM -0700, Andrew Morton wrote:
+ > which seems reasonable, I suppose, but a patch to devices.txt is needed
+ > please.
+ 
+ Umm, devices.txt isn managed by LANANA, better ask them.
+ 


Guess I should have said "different" major/minor. We have asked lanana
for our own major/minor - but, as yet, no response.... So we picked a
different one.


-- Pat

