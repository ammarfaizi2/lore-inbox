Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUASNhG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUASNhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:37:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1176 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264930AbUASNhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:37:03 -0500
Date: Mon, 19 Jan 2004 08:36:57 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Valentijn Sessink <linux-kernel-1074509192@mail.v.sessink.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: hard crash in IPsec
In-Reply-To: <20040119104854.GA2991@openoffice.nl>
Message-ID: <Xine.LNX.4.44.0401190835550.32548-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Valentijn Sessink wrote:

> 2.6.0/IPsec crashes, fully reproducable. Verified with 2.6.1.

Could you please verify if this still happens with Netfilter and SELinux 
disabled at compile time?


- James
-- 
James Morris
<jmorris@redhat.com>


