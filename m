Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264496AbUEDTl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbUEDTl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUEDTl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:41:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12220 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264496AbUEDTlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:41:03 -0400
Date: Tue, 4 May 2004 15:40:49 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: remy.gauguey@mindspeed.com
cc: linux-crypto@nl.linux.org, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6 crypto API and HW accelerators
In-Reply-To: <OF4ED7CD00.900586C8-ONC1256E8A.00491716-C1256E8A.004B08FD@nice.mindspeed.com>
Message-ID: <Xine.LNX.4.44.0405041537370.8760-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004 remy.gauguey@mindspeed.com wrote:

> Then, I would like to know if other people are working on the hardware
> crypto support in kernel 2.6.x.

I've heard of about 30 people saying they intend to work on it.

> If so, what would be the plan ? crypto api improvement or new IPsec
> specific hardware support ?

Here are some requirements and discussion summary:
http://samba.org/~jamesm/crypto/hardware_notes.txt


- James
-- 
James Morris
<jmorris@redhat.com>


