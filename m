Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWF3BmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWF3BmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWF3BmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:42:14 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22656 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932387AbWF3BmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:42:13 -0400
Date: Thu, 29 Jun 2006 18:39:05 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: stable@kernel.org, openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland Dreier <rolandd@cisco.com>
Subject: Re: [stable] [PATCH -stable] IB/mthca: restore missing PCI registers after reset
Message-ID: <20060630013905.GF11588@sequoia.sous-sol.org>
References: <20060628171428.GF19300@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628171428.GF19300@mellanox.co.il>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael S. Tsirkin (mst@mellanox.co.il) wrote:
> Hello, stable team!
> The pull of the following fix was requested by Roland Dreier just a couple of
> days before 2.6.17 came out, and so it seems it missed 2.6.17 by a narrow
> margin:
> 
> http://lkml.org/lkml/2006/6/13/164

Thanks, queued for the next -stable.
-chris
