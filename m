Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVJLXho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVJLXho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVJLXho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:37:44 -0400
Received: from mail.isurf.ca ([66.154.97.68]:6610 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S932100AbVJLXhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:37:43 -0400
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [OOPS] nfsv4 in linux 2.6.13 (-ck7)
Date: Wed, 12 Oct 2005 19:37:55 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200510121903.04485.ace@staticwave.ca> <200510121927.22296.ace@staticwave.ca> <20051012233159.GJ5856@shell0.pdx.osdl.net>
In-Reply-To: <20051012233159.GJ5856@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510121937.55434.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 12, 2005 19:31, Chris Wright wrote:
> In this case it's not very likely since others are seeing same problem
> under load.  However, a binary module can corrupt any kernel memory.
> So as a general rule all bets are off with a binary module loaded.

Thanks, I'll keep that in mind for next time. With regards to the patch in the other thread, 
should I try and patch the client, the server or both?

-- 
Gabriel A. Devenyi
ace@staticwave.ca
