Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424300AbWLHEKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424300AbWLHEKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 23:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424304AbWLHEKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 23:10:31 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:44276 "EHLO
	liaag1aa.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1424300AbWLHEKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 23:10:30 -0500
Date: Thu, 7 Dec 2006 23:02:03 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6 tmpfs/swap performance oddity
To: "Magnus Naeslund(k)" <mag@kite.se>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200612072306_MC3-1-D448-DB69@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <457706CB.20802@kite.se>

On Wed, 06 Dec 2006 19:07:07 +0100, Magnus Naeslund wrote:

> Is there any secret knobs that I can use to
> tune swap performance?

You might try changing /proc/sys/vm/page-cluster to 5.

-- 
Chuck
"Even supernovas have their duller moments."

