Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267501AbTAGVlD>; Tue, 7 Jan 2003 16:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTAGVlD>; Tue, 7 Jan 2003 16:41:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:56220 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267501AbTAGVlC>; Tue, 7 Jan 2003 16:41:02 -0500
Date: Tue, 07 Jan 2003 13:49:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (3/7) changes do_boot_cpu to return an error code
Message-ID: <17230000.1041976179@titus>
In-Reply-To: <595690000.1041970914@titus>
References: <595690000.1041970914@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, January 07, 2003 12:21:54 -0800 "Martin J. Bligh" <mbligh@aracnet.com> wrote:

> Changes do_boot_cpu to return an error code, instead of trying to
> work it out later by magic and voodoo. Removes the other usage
> of apicid->cpu which is hard to maintain cleanly.

Forgot to point out that James Cleverdon wrote this one. Corrected
in later email to Linus (along with some whitespace issues).

M.



