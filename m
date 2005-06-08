Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVFHACU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVFHACU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 20:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVFHACU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 20:02:20 -0400
Received: from dvhart.com ([64.146.134.43]:22184 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262045AbVFHACQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 20:02:16 -0400
Date: Tue, 07 Jun 2005 17:02:13 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <1006970000.1118188933@flay>
In-Reply-To: <20050607165656.2517b417.akpm@osdl.org>
References: <1004450000.1118188239@flay> <20050607165656.2517b417.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Diffprofile is wacko (HZ seems to be defaulting to 250 in -mm).
> 
> Oh crap, so it does.  That's wrong.
> 
>> If I factor it by 4x, I get:
> 
> Would it be possible to set it back to 100Hz, retest?

Sure. but you mean 1000, right?

M.

