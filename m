Return-Path: <linux-kernel-owner+w=401wt.eu-S932709AbWLNNHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbWLNNHU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWLNNHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:07:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43274 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932709AbWLNNHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:07:18 -0500
Date: Thu, 14 Dec 2006 08:07:04 -0500
From: Dave Jones <davej@redhat.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214130704.GB17565@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <4580E37F.8000305@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4580E37F.8000305@mbligh.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 09:39:11PM -0800, Martin J. Bligh wrote:

 > The Ubuntu feisty fawn mess was a dangerous warning bell of where we're
 > going. If we don't stand up at some point, and ban binary drivers, we
 > will, I fear, end up with an unsustainable ecosystem for Linux when
 > binary drivers become pervasive. I don't want to see Linux destroyed
 > like that.

Thing is, if kernel.org kernels get patched to disallow binary modules,
whats to stop Ubuntu (or anyone else) reverting that change in the
kernels they distribute ?  The landscape doesn't really change much,
given that the majority of Linux end-users are probably running
distro kernels.

		Dave

-- 
http://www.codemonkey.org.uk
