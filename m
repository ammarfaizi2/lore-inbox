Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUJZVwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUJZVwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbUJZVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:52:35 -0400
Received: from [217.7.64.195] ([217.7.64.195]:29339 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S261496AbUJZVw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:52:29 -0400
From: Ernst Herzberg <earny@net4u.de>
To: Dominik Karall <dominik.karall@gmx.net>
Subject: Re: Neighbour table overflow.
Date: Tue, 26 Oct 2004 23:52:20 +0200
User-Agent: KMail/1.7
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <200410261939.33541.dominik.karall@gmx.net>
In-Reply-To: <200410261939.33541.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410262352.20806.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 19:39, Dominik Karall wrote:
> can anybody explain why i get thousands of "Neighbour table overflow."
> messages? i didn't get such ones with older kernels (~2.6.6).

Do you set a default gateway?
