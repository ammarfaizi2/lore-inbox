Return-Path: <linux-kernel-owner+w=401wt.eu-S932118AbWLLSXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWLLSXZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWLLSXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:23:25 -0500
Received: from waste.org ([66.93.16.53]:46587 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbWLLSXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:23:25 -0500
Date: Tue, 12 Dec 2006 12:13:42 -0600
From: Matt Mackall <mpm@selenic.com>
To: Keiichi KII <k-keiichi@bx.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.19 0/6] proposal for dynamic configurable netconsole
Message-ID: <20061212181342.GI13687@waste.org>
References: <457E498C.1050806@bx.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457E498C.1050806@bx.jp.nec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 03:17:48PM +0900, Keiichi KII wrote:
> From: Keiichi KII <k-keiichi@bx.jp.nec.com>
> 
> The netconsole is a very useful module for collecting kernel message under
> certain circumstances(e.g. disk logging fails, serial port is unavailable).

FYI, there's a robot named Dave Miller who will eventually notice your
email and scold you for not cc:ing it to netdev, claiming that he
doesn't read LKML.

-- 
Mathematics is the supreme nostalgia of our time.
