Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWHBTdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWHBTdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWHBTdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:33:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37273 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932159AbWHBTdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:33:14 -0400
Date: Wed, 2 Aug 2006 14:33:03 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, serue@us.ibm.com,
       Stephen Smalley <sds@tycho.nsa.gov>,
       Davi Arnaut <davi.arnaut@gmail.com>, jmorris@namei.org,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: remove BSD secure level security module
Message-ID: <20060802193303.GA5540@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060802180708.GQ2654@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802180708.GQ2654@sequoia.sous-sol.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 11:07:08AM -0700, Chris Wright wrote:
> This code has suffered from broken core design and lack of developer
> attention.  Broken security modules are too dangerous to leave around.
> It is time to remove this one.
> 
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Cc: Michael Halcrow <mhalcrow@us.ibm.com>
> Cc: Serge Hallyn <serue@us.ibm.com>
> Cc: Davi Arnaut <davi.arnaut@gmail.com>

My mail server delivered Greg's message before this one, but it looks
like both patches accomplish the same thing.

Acked-by: Michael Halcrow <mhalcrow@us.ibm.com>
