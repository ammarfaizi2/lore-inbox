Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVABU2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVABU2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVABU2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:28:14 -0500
Received: from one.firstfloor.org ([213.235.205.2]:25270 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261322AbVABU2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:28:05 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
References: <20050102200032.GA8623@lst.de>
From: Andi Kleen <ak@muc.de>
Date: Sun, 02 Jan 2005 21:28:00 +0100
In-Reply-To: <20050102200032.GA8623@lst.de> (Christoph Hellwig's message of
 "Sun, 2 Jan 2005 21:00:32 +0100")
Message-ID: <m1mzvry3sf.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> There's been a bugtraq report about a root exploit with modular
> capabilities LSM support out for more than a week.

It was a root exploit only triggerable by root. Not exactly
what I would call a real problem.

-Andi
