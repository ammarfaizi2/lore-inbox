Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUAAB6T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 20:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265320AbUAAB6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 20:58:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47048 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265317AbUAAB6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 20:58:18 -0500
Date: Thu, 1 Jan 2004 01:58:09 +0000
From: Dave Jones <davej@redhat.com>
To: Michael Clark <michael@metaparadigm.com>
Cc: rudi@lambda-computing.de, ivern@acm.org, linux-kernel@vger.kernel.org
Subject: Re: File change notification
Message-ID: <20040101015809.GA14930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michael Clark <michael@metaparadigm.com>, rudi@lambda-computing.de,
	ivern@acm.org, linux-kernel@vger.kernel.org
References: <3FF2FC85.5070906@lambda-computing.de> <3FF31366.30206@acm.org> <3FF31A15.4070307@lambda-computing.de> <3FF377A8.6040302@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF377A8.6040302@metaparadigm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 09:28:08AM +0800, Michael Clark wrote:
 > Have you had a look at dazuko. It provides a consistent file access
 > notification mechanism (and also intervention for denying access) across
 > linux and freebsd. It is currently being used by various on-access
 > virus scanners. It is under active development and supports 2.6 (and 2.4)

Candidate for "Wackiest sys_call_table patching 2004".
In a word "ick". Code not to be read on a full stomach.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
