Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031241AbWKUWmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031241AbWKUWmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031245AbWKUWmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:42:11 -0500
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:14556 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1031241AbWKUWmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:42:10 -0500
Date: Tue, 21 Nov 2006 17:39:52 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: problem with booting on linux-2.6.18.3
To: Antonin Kolisek <akolisek@linuxx.hyperlinx.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200611211741_MC3-1-D265-B36E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200611201519.40251.akolisek@linuxx.hyperlinx.cz>

On Mon, 20 Nov 2006 15:19:40 +0100, Antonin Kolisek wrote:

> i want to report one problem i last kernel tree (Vanilla 2.6.18.2 and 
> 2.6.18.3). 
> When i boot my PC i get this message:
> 
> unknown interrupt or fault at EIP 0001006 00000060 c038feca

Can you look in System.map of the exact kernel that is failing and
find the symbol just before c038feca, then post that to the list?

If you can't do that, just post all the symbols that start with
c038f

-- 
Chuck
"Even supernovas have their duller moments."
