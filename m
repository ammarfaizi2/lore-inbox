Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbUJ3SCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbUJ3SCo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUJ3SCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:02:44 -0400
Received: from gate.in-addr.de ([212.8.193.158]:3472 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261249AbUJ3SBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:01:54 -0400
Date: Sat, 30 Oct 2004 19:48:02 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: md and multipathing
Message-ID: <20041030174802.GK32712@marowsky-bree.de>
References: <20041029002502.80901.qmail@web51805.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041029002502.80901.qmail@web51805.mail.yahoo.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-10-28T17:25:02, Phy Prabab <phyprabab@yahoo.com> wrote:

> I have a question concerning md driver: is there a way
> to have a multipath md that is mulitplexed?

With 2.6, use the Device-Mapper multipath module.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

