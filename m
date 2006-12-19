Return-Path: <linux-kernel-owner+w=401wt.eu-S1753030AbWLSQmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbWLSQmO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 11:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbWLSQmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 11:42:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45131 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbWLSQmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 11:42:13 -0500
Date: Tue, 19 Dec 2006 11:41:46 -0500
From: Dave Jones <davej@redhat.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: my handy-dandy, "coding style" script
Message-ID: <20061219164146.GI25461@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 10:46:24AM -0500, Robert P. J. Day wrote:
 > 
 >   just for fun, i threw the following together to peruse the tree (or
 > any subdirectory) and look for stuff that violates the CodingStyle
 > guide.  clearly, it's far from complete and very ad hoc, but it's
 > amusing.  extra searches happily accepted.

I had a bunch of similar greps that I've recently been half-assedly
putting together into a single script too.
See http://www.codemonkey.org.uk/projects/findbugs/

		Dave

-- 
http://www.codemonkey.org.uk
