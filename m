Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWHBS7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWHBS7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWHBS7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:59:22 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:42191 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932173AbWHBS7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:59:20 -0400
Date: Wed, 2 Aug 2006 14:59:16 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Chris Wright <chrisw@sous-sol.org>
cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       serue@us.ibm.com, Stephen Smalley <sds@tycho.nsa.gov>,
       Davi Arnaut <davi.arnaut@gmail.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: remove BSD secure level security module
In-Reply-To: <20060802180708.GQ2654@sequoia.sous-sol.org>
Message-ID: <Pine.LNX.4.64.0608021458590.23019@d.namei>
References: <20060802180708.GQ2654@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006, Chris Wright wrote:

> This code has suffered from broken core design and lack of developer
> attention.  Broken security modules are too dangerous to leave around.
> It is time to remove this one.
> 
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>
