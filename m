Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWAWASp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWAWASp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 19:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWAWASp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 19:18:45 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:16310 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S932360AbWAWASp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 19:18:45 -0500
Date: Sun, 22 Jan 2006 19:15:28 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/coda/: proper prototypes
Message-ID: <20060123001528.GC31997@delft.aura.cs.cmu.edu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20060121003517.GJ31803@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121003517.GJ31803@stusta.de>
User-Agent: Mutt/1.5.11
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 01:35:17AM +0100, Adrian Bunk wrote:
> This patch introduces a file fs/coda/coda_int.h with proper prototypes 
> for some code.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
  Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>

Looks good. Is this going to be included in your cleanup patch series,
or do you want me to forward it?

Jan
