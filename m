Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVD0OvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVD0OvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVD0OvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:51:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13802 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261641AbVD0OvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:51:16 -0400
Date: Wed, 27 Apr 2005 07:48:39 -0700
From: Paul Jackson <pj@sgi.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1a/7] dlm: core locking
Message-Id: <20050427074839.48c2d6b0.pj@sgi.com>
In-Reply-To: <20050425165705.GA11938@redhat.com>
References: <20050425165705.GA11938@redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you spell out what "DLM" stands for at the top of the header file,
like you do in the configuration blurb, something like the following:

< * Interface to DLM - routines and structures to use DLM lockspaces.

> * Interface to Distributed Lock Manager (DLM) lockspaces.

To some outsiders, DLM is just another unrecognized three letter
acronym.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
