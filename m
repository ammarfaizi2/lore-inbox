Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUGHSPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUGHSPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 14:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUGHSPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 14:15:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39881 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264058AbUGHSPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 14:15:20 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: David Teigland <teigland@redhat.com>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Thu, 8 Jul 2004 14:22:19 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>
References: <200407050209.29268.phillips@redhat.com> <20040708091043.GS12255@marowsky-bree.de> <20040708105338.GA16115@redhat.com>
In-Reply-To: <20040708105338.GA16115@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407081422.19566.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Thursday 08 July 2004 06:53, David Teigland wrote:
> We have a symmetric, kernel-based, stand-alone cluster manager (CMAN)
> that has no ties to anything else whatsoever.  It'll simply run and
> answer the question "who's in the cluster?" by providing a list of
> names/nodeids.

While we're in here, could you please explain why CMAN needs to be 
kernel-based?  (Just thought I'd broach the question before Christoph 
does.)

Regards,

Daniel
