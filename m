Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268063AbUHFEm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268063AbUHFEm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHFEm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:42:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268063AbUHFEmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:42:55 -0400
Date: Fri, 6 Aug 2004 00:42:38 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       <mludvig@suse.cz>, <cryptoapi@lists.logix.cz>,
       <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: [PATCH]
In-Reply-To: <20040806042852.GD23994@certainkey.com>
Message-ID: <Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Jean-Luc Cooke wrote:

> James,
>   Back to your question:
>     I want to replace the legacy MD5 and the incorrectly implemented SHA-1
>     implementations from driver/char/random.c

Incorrectly implemented?  Do you mean not appending the bit count?


- James
-- 
James Morris
<jmorris@redhat.com>


