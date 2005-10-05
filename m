Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVJEQoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVJEQoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVJEQoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:44:11 -0400
Received: from mail21.sea5.speakeasy.net ([69.17.117.23]:26527 "EHLO
	mail21.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030241AbVJEQoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:44:09 -0400
Date: Wed, 5 Oct 2005 12:44:07 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management
In-Reply-To: <29942.1128529714@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.63.0510051241580.23070@excalibur.intercode>
References: <29942.1128529714@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, David Howells wrote:

> Key management access control through LSM is enabled by CONFIG_SECURITY_KEYS.

Any reason why this is configurable?  Why wouldn't someone want this?


- James
-- 
James Morris
<jmorris@namei.org>
