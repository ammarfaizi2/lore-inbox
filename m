Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTJBW1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 18:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTJBW1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 18:27:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55569 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263510AbTJBW1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 18:27:34 -0400
Date: Thu, 2 Oct 2003 18:25:36 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: reg@dwf.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 - Network doesn't come up.
In-Reply-To: <200310022138.h92Lc67x005420@orion.dwf.com>
Message-ID: <Pine.LNX.4.44.0310021824460.18914-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Oct 2003 reg@dwf.com wrote:

> NETWORKING. is a nogo.

Do you have CONFIG_PACKET and CONFIG_INET?


- James
-- 
James Morris
<jmorris@redhat.com>

