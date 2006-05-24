Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbWEXGNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbWEXGNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 02:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWEXGNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 02:13:50 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:31207 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932613AbWEXGNt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 02:13:49 -0400
Date: Wed, 24 May 2006 09:13:42 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: "=?big5?B?amVzc2VcKKvYv7NcKQ==?=" <jesse@icplus.com.tw>
cc: Francois Romieu <romieu@fr.zoreil.com>, David Vrabel <dvrabel@cantab.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net, akpm@osdl.org
Subject: Re: Sign-off for the IP1000A driver before inclusion
In-Reply-To: <044a01c67ef8$9bdd0420$4964a8c0@icplus.com.tw>
Message-ID: <Pine.LNX.4.58.0605240911400.26629@sbz-30.cs.Helsinki.FI>
References: <84144f020605230001s32b29f59w8f95c67fad7b380d@mail.gmail.com>
 <044a01c67ef8$9bdd0420$4964a8c0@icplus.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006, jesse\(??\)\) wrote:
> We had read this document, but we can't find any blank at which we can sign.
> Could you tell us where we can sign it off.

You sign it off in the patch submission.  It's enough that you agree on it 
and let us know a sign off line:

Signed-off-by: John Doe <john.doe@somewhere.com>

which the patch submitter (probably Francois) adds to the patch 
when it is being submitted.  There is no actual documentation you need to 
sign off.  Thanks.

					Pekka
