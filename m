Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269255AbUJFNHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269255AbUJFNHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUJFNHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:07:20 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:57467 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269255AbUJFNHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:07:15 -0400
Subject: Re: Badness in enable_irq with 2.6.9-rc3-mm2-vp-t1
From: Paul Fulghum <paulkf@microgate.com>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041006145546.1a611d27.mdeboer@iua.upf.es>
References: <20041006145546.1a611d27.mdeboer@iua.upf.es>
Content-Type: text/plain
Message-Id: <1097067996.1990.2.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 08:06:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 07:55, Maarten de Boer wrote:
> When booting the new kernel, problems occur with the ethernet device
> (e100), and, not surprisingly, networking fails. Any idea?

This is a known problem.
The maintainers are working on a solution.

It is only a warning and the e100 will
continue to work.

-- 
Paul Fulghum
paulkf@microgate.com

