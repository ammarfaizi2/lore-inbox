Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUAOSQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 13:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUAOSQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 13:16:38 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:24005 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265203AbUAOSQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 13:16:35 -0500
Date: Thu, 15 Jan 2004 13:16:21 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jari Ruusu <jariruusu@users.sourceforge.net>
cc: Jim Faulkner <jfaulkne@ccs.neu.edu>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
In-Reply-To: <4006C665.3065DFA1@users.sourceforge.net>
Message-ID: <Xine.LNX.4.44.0401151315520.16587-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004, Jari Ruusu wrote:

> Jim,
> If you want your data secure, you need to re-encrypt your data anyway.
> Mainline loop crypto implementation has exploitable vulnerability that is
> equivalent to back door.

What exactly is this vulnerability?


- James
-- 
James Morris
<jmorris@redhat.com>


